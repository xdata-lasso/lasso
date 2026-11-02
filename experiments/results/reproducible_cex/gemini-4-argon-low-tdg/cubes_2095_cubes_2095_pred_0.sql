-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic AVG calculation, duplicate elevation values (AVG vs AVG(DISTINCT)), fractional averages, and inverse correlation between country name and average elevation to verify primary vs secondary sort keys.
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (1, 'A1', 'C1', 'Zambia', 10.0, 10.0, 10, 'AA1', 'AAA1');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (2, 'A2', 'C2', 'Zambia', 11.0, 11.0, 10, 'AA2', 'AAA2');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (3, 'A3', 'C3', 'Zambia', 12.0, 12.0, 40, 'AA3', 'AAA3');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (4, 'A4', 'C4', 'Albania', 20.0, 20.0, 50, 'AA4', 'AAA4');
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (5, 'A5', 'C5', 'Albania', 21.0, 21.0, 51, 'AA5', 'AAA5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanelevation AS avg_elevation_, country FROM (SELECT country, AVG(elevation) AS meanelevation FROM airports GROUP BY country) ORDER BY avg_elevation_, country NULLS LAST;

/*
Gold Result:
(20.0, 'Zambia')
(50.5, 'Albania')
*/

-- Prediction Query
SELECT AVG(elevation), country FROM airports GROUP BY country;

/*
Prediction Result:
(50.5, 'Albania')
(20.0, 'Zambia')
*/