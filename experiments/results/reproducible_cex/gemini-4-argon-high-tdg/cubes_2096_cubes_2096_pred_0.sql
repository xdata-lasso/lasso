-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'Air Greenland', 'GL', 'GRL', 'GREENLANDAIR', 'Greenland', 'Y');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'Copenhagen Airport', 'Copenhagen', 'Denmark', 12.656, 55.618, 17, 'CPH', 'EKCH');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'Aarhus Airport', 'Aarhus', 'Denmark', 10.619, 56.300, 82, 'AAR', 'EKAH');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'Lowercase Test Airport', 'Nuuk', 'greenland', -51.678, 64.190, 283, 'GOH', 'BGGH');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'Null Country Airport', 'Nuuk', NULL, -51.678, 64.190, 283, 'NUL', 'BGNL');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n_distinct" AS "count_distinct_city_" FROM (SELECT "country", COUNT(DISTINCT "city") AS "n_distinct" FROM "airports" GROUP BY "country") WHERE ("country" = 'Greenland') ORDER BY count_distinct_city_;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(DISTINCT city) FROM airports WHERE country = 'Greenland';

/*
Prediction Result:
(0,)
*/