-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty result set when 'Iceland' is not present in airports.country (kills MAX without GROUP BY mutants,
-- case-sensitivity mutants, and mutants filtering by city/name/airline.country instead of airports.country).
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'Gardermoen', 'Oslo', 'Norway', 60.1939, 11.1004, 681, 'OSL', 'ENGM');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'Vagar', 'Vagar', 'Faroe Islands', 62.0636, -7.2772, 280, 'FAE', 'EKVG');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'Iceland Airfield', 'Iceland', 'United States', 40.0, -75.0, 500, 'ICA', 'KICA');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'Fake Keflavik', 'Reykjavik', 'iceland', 63.98, -22.60, 999, 'FKF', 'BIFK');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'Icelandair', 'FI', 'ICE', 'ICEAIR', 'Iceland', 'Y');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (1, 1, 1, 2, 'FAE', 'OSL', 'FI', '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "maxelevation" AS "max_elevation_" FROM (SELECT "country", MAX("elevation") AS "maxelevation" FROM "airports" GROUP BY "country") WHERE ("country" = 'Iceland') ORDER BY max_elevation_;

/*
Gold Result:
*/

-- Prediction Query
SELECT MAX(elevation) FROM airports WHERE country = 'Iceland';

/*
Prediction Result:
(None,)
*/