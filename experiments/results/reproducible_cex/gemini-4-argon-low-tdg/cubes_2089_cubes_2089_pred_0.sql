-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions for elevation (-51, -50, -49, 0, 49, 50, 51) and NULLs.
-- Kills mutants changing > to >=, <= to <, AND to OR, or mishandling NULL elevations.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Bound_Minus_51', 'City1', 'Country1', 10.0, 10.0, -51, 'B51', 'KB51');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Bound_Minus_50', 'City2', 'Country2', 20.0, 20.0, -50, 'B50', 'KB50');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Bound_Minus_49', 'City3', 'Country3', 30.0, 30.0, -49, 'B49', 'KB49');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Bound_Zero', 'City4', 'Country4', 40.0, 40.0, 0, 'B00', 'KB00');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Bound_Plus_49', 'City5', 'Country5', 50.0, 50.0, 49, 'P49', 'KP49');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Bound_Plus_50', 'City6', 'Country6', 60.0, 60.0, 50, 'P50', 'KP50');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Bound_Plus_51', 'City7', 'Country7', 70.0, 70.0, 51, 'P51', 'KP51');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Bound_Null_Elev', 'City8', 'Country8', 80.0, 80.0, NULL, 'BNL', 'KBNL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM airports WHERE (elevation > -50 AND elevation <= 50) ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Bound_Minus_49',)
('Bound_Plus_49',)
('Bound_Plus_50',)
('Bound_Zero',)
*/

-- Prediction Query
SELECT name FROM airports WHERE elevation BETWEEN -50 AND 50;

/*
Prediction Result:
('Bound_Minus_50',)
('Bound_Minus_49',)
('Bound_Zero',)
('Bound_Plus_49',)
('Bound_Plus_50',)
*/