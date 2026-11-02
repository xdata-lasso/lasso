-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "airports" ("apid", "name", "country") VALUES (1, 'Zeta Airport', 'Cuba');
INSERT INTO "airports" ("apid", "name", "country") VALUES (2, 'Alpha Airport', 'Argentina');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airports" WHERE ("country" = 'Cuba' OR "country" = 'Argentina') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Alpha Airport',)
('Zeta Airport',)
*/

-- Prediction Query
SELECT name FROM airports WHERE country = 'Cuba' OR country = 'Argentina';

/*
Prediction Result:
('Zeta Airport',)
('Alpha Airport',)
*/