-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic GROUP BY, COUNT(*) vs COUNT(country) with NULLs, secondary sorting on country (including NULLS LAST), and ordering directions.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Airport A1', 'City A', 'Canada', 0.0, 0.0, 100, 'AA1', 'AAA1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Airport B1', 'City B', 'Brazil', 0.0, 0.0, 100, 'BB1', 'BBB1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Airport N1', 'City N', NULL, 0.0, 0.0, 100, 'NN1', 'NNN1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Airport C1', 'City C', 'Australia', 0.0, 0.0, 100, 'CC1', 'CCC1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Airport C2', 'City C', 'Australia', 0.0, 0.0, 100, 'CC2', 'CCC2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Airport D1', 'City D', 'Denmark', 0.0, 0.0, 100, 'DD1', 'DDD1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Airport D2', 'City D', 'Denmark', 0.0, 0.0, 100, 'DD2', 'DDD2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airports GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'Brazil')
(1, 'Canada')
(1, None)
(2, 'Australia')
(2, 'Denmark')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airports GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST;

/*
Prediction Result:
(2, 'Australia')
(2, 'Denmark')
(1, 'Brazil')
(1, 'Canada')
(1, None)
*/