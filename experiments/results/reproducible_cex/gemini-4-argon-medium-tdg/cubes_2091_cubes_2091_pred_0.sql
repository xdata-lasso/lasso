-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests NULL handling in GROUP BY, COUNT(*) vs COUNT(country), and NULLS LAST in secondary sort with count ties.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'A1', 'C1', NULL, 10.0, 20.0, 100, 'AA1', 'AAA1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'A2', 'C2', NULL, 11.0, 21.0, 100, 'AA2', 'AAA2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'A3', 'C3', 'USA', 12.0, 22.0, 100, 'AA3', 'AAA3');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'A4', 'C4', 'USA', 13.0, 23.0, 100, 'AA4', 'AAA4');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'A5', 'C5', 'Canada', 14.0, 24.0, 100, 'AA5', 'AAA5');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'A6', 'C6', 'Brazil', 15.0, 25.0, 100, 'AA6', 'AAA6');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'A7', 'C7', 'Brazil', 16.0, 26.0, 100, 'AA7', 'AAA7');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'A8', 'C8', 'Brazil', 17.0, 27.0, 100, 'AA8', 'AAA8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airports GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Canada')
(2, 'USA')
(2, None)
(3, 'Brazil')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airports GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST;

/*
Prediction Result:
(3, 'Brazil')
(2, 'USA')
(2, None)
(1, 'Canada')
*/