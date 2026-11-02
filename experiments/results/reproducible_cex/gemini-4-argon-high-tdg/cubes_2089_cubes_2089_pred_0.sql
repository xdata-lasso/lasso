-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Zulu Field', 'CityA', 'CountryA', 100.0, 100.0, -49, 'ZUL', 'KZUL');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Alpha Base', 'CityB', 'CountryB', -100.0, -100.0, 50, 'ALP', 'KALP');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Echo Park', 'CityC', 'CountryC', 200.0, 200.0, 0, 'ECH', 'KECH');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Border Low Exact', 'CityD', 'CountryD', 10.0, 10.0, -50, 'BLE', 'KBLE');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Border Low Out', 'CityE', 'CountryE', 15.0, 15.0, -51, 'BLO', 'KBLO');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Border High In', 'CityF', 'CountryF', 120.0, -120.0, 49, 'BHI', 'KBHI');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Border High Out', 'CityG', 'CountryG', 5.0, 5.0, 51, 'BHO', 'KBHO');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Null Elevation', 'CityH', 'CountryH', 0.0, 0.0, NULL, 'NUL', 'KNUL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM airports WHERE (elevation > -50 AND elevation <= 50) ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Alpha Base',)
('Border High In',)
('Echo Park',)
('Zulu Field',)
*/

-- Prediction Query
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50;

/*
Prediction Result:
('Zulu Field',)
('Alpha Base',)
('Echo Park',)
('Border Low Exact',)
('Border High In',)
*/