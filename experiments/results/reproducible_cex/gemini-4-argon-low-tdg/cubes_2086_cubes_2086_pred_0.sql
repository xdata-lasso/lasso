-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when NO rows match the 'Russia' filter.
-- Reference Query returns 0 rows (due to GROUP BY on empty filtered set).
-- Mutants omitting GROUP BY will return 1 row with count 0.
-- Mutants querying 'airports' instead of 'airlines' will return a count of 2.
-- Mutants with wrong WHERE operators (!=, IS NULL, LIKE '%Russia%', case-insensitivity) will return non-empty results.
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'Delta', 'DL', 'DAL', 'DELTA', 'United States', 'Y');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (2, 'Unknown Air', NULL, NULL, NULL, NULL, 'N');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (3, 'Lower Russia', 'LR', 'LRS', 'LOWRUS', 'russia', 'Y');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (4, 'Belavia', 'B2', 'BRU', 'BELAVIA', 'Belarus and Russia', 'Y');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (101, 'Sheremetyevo', 'Moscow', 'Russia', 37.4146, 55.9726, 622, 'SVO', 'UUEE');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (102, 'Domodedovo', 'Moscow', 'Russia', 37.9061, 55.4086, 588, 'DME', 'UUDD');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (1001, 1, 101, 102, 'DME', 'SVO', 'DL', 'N');
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