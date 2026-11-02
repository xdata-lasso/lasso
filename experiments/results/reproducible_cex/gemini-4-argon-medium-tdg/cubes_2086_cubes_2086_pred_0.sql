-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set (0 rows returned) vs 1 row with count 0 when no airlines match 'Russia', while 'Russia' exists in other columns/tables and near-miss strings exist in airlines.country.
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (10, 'Pulkovo', 'St. Petersburg', 'Russia', 59.800, 30.262, 78, 'LED', 'ULLI');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (10, 'Russia', 'RU', 'RUS', 'RUSSIA', 'United States', 'Y');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (11, 'Belavia', 'B2', 'BRU', 'BELARUS AVIA', 'Russian Federation', 'Y');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (12, 'Lower Air', 'LA', 'LOW', 'LOWER', 'russia', 'Y');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (13, 'Null Country Air', 'NC', 'NUL', 'NULLAIR', NULL, 'Y');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (10, 10, 10, 10, 'LED', 'LED', 'RU', '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "country", COUNT(*) AS "n" FROM (SELECT * FROM "airlines" WHERE ("country" = 'Russia')) GROUP BY country) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM airlines WHERE country = 'Russia';

/*
Prediction Result:
(0,)
*/