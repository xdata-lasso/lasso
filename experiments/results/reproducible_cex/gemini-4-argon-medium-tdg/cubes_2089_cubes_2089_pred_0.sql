-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for elevation (> -50 AND <= 50), out-of-bounds values, and NULL elevation.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Below Lower Bound', 'CityA', 'CountryA', 0.0, 0.0, -51, 'AAA', 'AAAA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'At Lower Bound', 'CityB', 'CountryB', 0.0, 0.0, -50, 'BBB', 'BBBB');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Just Inside Lower Bound', 'CityC', 'CountryC', 0.0, 0.0, -49, 'CCC', 'CCCC');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Zero Elevation', 'CityD', 'CountryD', 0.0, 0.0, 0, 'DDD', 'DDDD');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Just Inside Upper Bound', 'CityE', 'CountryE', 0.0, 0.0, 49, 'EEE', 'EEEE');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'At Upper Bound', 'CityF', 'CountryF', 0.0, 0.0, 50, 'FFF', 'FFFF');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Above Upper Bound', 'CityG', 'CountryG', 0.0, 0.0, 51, 'GGG', 'GGGG');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Null Elevation', 'CityH', 'CountryH', 0.0, 0.0, NULL, 'HHH', 'HHHH');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM airports WHERE (elevation > -50 AND elevation <= 50) ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('At Upper Bound',)
('Just Inside Lower Bound',)
('Just Inside Upper Bound',)
('Zero Elevation',)
*/

-- Prediction Query
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50;

/*
Prediction Result:
('At Lower Bound',)
('Just Inside Lower Bound',)
('Zero Elevation',)
('Just Inside Upper Bound',)
('At Upper Bound',)
*/