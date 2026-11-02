-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (13, 'Iceland13', 'Iceland13', 'Iceland14', 13, 13, NULL, 'Iceland13', 'Iceland13');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (12, 'Iceland13', 'Iceland13', 'Iceland13', 'Iceland13', 'Iceland13', 'Iceland13');
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