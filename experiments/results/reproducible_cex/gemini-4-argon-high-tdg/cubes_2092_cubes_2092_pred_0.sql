-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (100, 'East 34th St Heliport', 'New York', 'United States', -73.9700, 40.7400, 10, 'TSS', 'KTSS');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (10, 'East 34th St Heliport', 'New York', 'United States', -73.9701, 40.7401, 55, 'TS2', 'KTS2');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (50, 'East 34th St Heliport', 'New York', 'United States', -73.9702, 40.7402, 10, 'TS3', 'KTS3');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (5, 'West 30th St Heliport', 'New York', 'United States', -74.0070, 40.7545, 7, 'JRA', 'KJRA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "city", "country", "elevation" FROM "airports" WHERE ("city" = 'New York') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('East 34th St Heliport', 'New York', 'United States', 55)
('East 34th St Heliport', 'New York', 'United States', 10)
('East 34th St Heliport', 'New York', 'United States', 10)
('West 30th St Heliport', 'New York', 'United States', 7)
*/

-- Prediction Query
SELECT name, city, country, elevation FROM airports WHERE city = 'New York';

/*
Prediction Result:
('West 30th St Heliport', 'New York', 'United States', 7)
('East 34th St Heliport', 'New York', 'United States', 55)
('East 34th St Heliport', 'New York', 'United States', 10)
('East 34th St Heliport', 'New York', 'United States', 10)
*/