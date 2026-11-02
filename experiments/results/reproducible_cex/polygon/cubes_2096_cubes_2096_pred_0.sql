-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (10, 12, 14, 14, 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (9, 12, 14, 14, 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (13, 'Greenland14', NULL, 'Greenland16', 14, 14, 14, 'Greenland14', 'Greenland14');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (14, 'Greenland14', NULL, 'Greenland15', 14, 14, 14, 'Greenland14', 'Greenland14');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (11, 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (12, 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14', 'Greenland14');
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