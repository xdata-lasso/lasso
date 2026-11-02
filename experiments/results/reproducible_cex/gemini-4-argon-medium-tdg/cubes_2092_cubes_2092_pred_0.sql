-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, sorting by name, secondary sorting by apid, and duplicate projected rows (kills DISTINCT mutants, ORDER BY direction mutants, and WHERE column confusion).
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'LaGuardia', 'New York', 'USA', -73.87, 40.77, 21, 'LGA', 'KLGA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'JFK International', 'New York', 'USA', -73.77, 40.64, 13, 'JFK', 'KJFK');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (20, 'JFK International', 'New York', 'USA', -73.77, 40.64, 13, 'JFK', 'KJFK');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (15, 'Newark Liberty', 'Newark', 'USA', -74.16, 40.69, 18, 'EWR', 'KEWR');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (25, 'New York', 'Albany', 'USA', -73.80, 42.74, 285, 'ALB', 'KALB');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (30, 'Central Park Heliport', 'new york', 'USA', -73.96, 40.78, 100, 'NYC', 'KNYC');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (35, 'Unknown City Airport', NULL, 'USA', 0.0, 0.0, 0, 'UNK', 'KUNK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "city", "country", "elevation" FROM "airports" WHERE ("city" = 'New York') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('JFK International', 'New York', 'USA', 13)
('JFK International', 'New York', 'USA', 13)
('LaGuardia', 'New York', 'USA', 21)
*/

-- Prediction Query
SELECT name, city, country, elevation FROM airports WHERE city = 'New York';

/*
Prediction Result:
('JFK International', 'New York', 'USA', 13)
('LaGuardia', 'New York', 'USA', 21)
('JFK International', 'New York', 'USA', 13)
*/