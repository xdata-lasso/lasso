-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, AVG(DISTINCT) vs AVG(ALL), floating-point vs integer division, SUM/COUNT/MIN/MAX mutations, and primary ORDER BY avg_elevation_ ASC.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'A1', 'C1', 'CountryA', 0.0, 0.0, 10, 'AA1', 'AAA1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'A2', 'C2', 'CountryA', 0.0, 0.0, 10, 'AA2', 'AAA2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'A3', 'C3', 'CountryA', 0.0, 0.0, 21, 'AA3', 'AAA3');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'B1', 'C4', 'CountryB', 0.0, 0.0, 5, 'BB1', 'BBB1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'B2', 'C5', 'CountryB', 0.0, 0.0, 15, 'BB2', 'BBB2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'C1', 'C6', 'CountryC', 0.0, 0.0, 100, 'CC1', 'CCC1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanelevation AS avg_elevation_, country FROM (SELECT country, AVG(elevation) AS meanelevation FROM airports GROUP BY country) ORDER BY avg_elevation_, country NULLS LAST;

/*
Gold Result:
(10.0, 'CountryB')
(13.666666666666666, 'CountryA')
(100.0, 'CountryC')
*/

-- Prediction Query
SELECT AVG(elevation), country FROM airports GROUP BY country;

/*
Prediction Result:
(13.666666666666666, 'CountryA')
(10.0, 'CountryB')
(100.0, 'CountryC')
*/