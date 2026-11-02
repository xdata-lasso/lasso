-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (exact match vs partial/case/null/wrong column), duplicates (SELECT vs SELECT DISTINCT), and primary ORDER BY (name ASC vs DESC).
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'Zulu Airport', 'Goroka', 'Papua New Guinea', -6.08, 145.39, 5282, 'GKA', 'AYGA');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'Alpha Airport', 'Goroka', 'Papua New Guinea', -6.08, 145.39, 5282, 'GKB', 'AYGB');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'Alpha Airport', 'Goroka', 'Papua New Guinea', -6.08, 145.39, 5282, 'GKC', 'AYGC');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'Goroka', 'Port Moresby', 'Papua New Guinea', -9.44, 147.22, 146, 'POM', 'AYPY');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (5, 'Lower Airport', 'goroka', 'Papua New Guinea', -6.08, 145.39, 5282, 'GKD', 'AYGD');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (6, 'Prefix Airport', 'Goroka City', 'Papua New Guinea', -6.08, 145.39, 5282, 'GKE', 'AYGE');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (7, 'Null City Airport', NULL, 'Papua New Guinea', -6.08, 145.39, 5282, 'GKF', 'AYGF');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (8, 'Country Match Airport', 'Madang', 'Goroka', -5.20, 145.78, 20, 'MAG', 'AYMD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airports" WHERE ("city" = 'Goroka') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Alpha Airport',)
('Alpha Airport',)
('Zulu Airport',)
*/

-- Prediction Query
SELECT name FROM airports WHERE city = 'Goroka';

/*
Prediction Result:
('Zulu Airport',)
('Alpha Airport',)
('Alpha Airport',)
*/