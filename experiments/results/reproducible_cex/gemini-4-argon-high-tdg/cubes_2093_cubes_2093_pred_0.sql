-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'Zeta Field', 'Goroka', 'Papua New Guinea', -6.08169, 145.391998, 5282, 'GKA', 'AYGA');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'Alpha Airbase', 'Goroka', 'Papua New Guinea', -6.09000, 145.400000, 5100, 'GKB', 'AYGB');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'Goroka', 'Lae', 'Goroka', -6.56980, 146.725998, 239, 'LAE', 'AYNZ');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'Beta Terminal', 'Madang', 'Papua New Guinea', -5.20708, 145.789001, 20, 'MAG', 'AYMD');
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'Goroka Air', 'GA', 'GKA', 'GOROKA', 'Goroka', 'Y');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (1, 1, 2, 3, 'LAE', 'GKB', 'GA', 'Y');
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (2, 1, 2, 4, 'MAG', 'GKB', 'GA', 'N');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "airports" WHERE ("city" = 'Goroka') ORDER BY name, airports.apid NULLS LAST;

/*
Gold Result:
('Alpha Airbase',)
('Zeta Field',)
*/

-- Prediction Query
SELECT name FROM airports WHERE city = 'Goroka';

/*
Prediction Result:
('Zeta Field',)
('Alpha Airbase',)
*/