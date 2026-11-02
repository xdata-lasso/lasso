-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for maximum elevation with duplicate and distinct countries, out-of-order insertion, and lower elevations.
-- Catches mutants using LIMIT 1, DISTINCT, ORDER BY DESC, or MIN instead of MAX.
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Ap1', 'City1', 'Zambia', 10.0, 20.0, 5000, 'AA1', 'AAA1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Ap2', 'City2', 'Argentina', 11.0, 21.0, 5000, 'AA2', 'AAA2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Ap3', 'City3', 'Argentina', 12.0, 22.0, 5000, 'AA3', 'AAA3');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Ap4', 'City4', 'Brazil', 13.0, 23.0, 1000, 'AA4', 'AAA4');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Ap5', 'City5', 'Canada', 14.0, 24.0, -50, 'AA5', 'AAA5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT LHS.elevation AS elevation, RHS.apid AS apid, RHS.name AS name, RHS.city AS city, RHS.country AS country, RHS.x AS x, RHS.y AS y, RHS.iata AS iata, RHS.icao AS icao FROM (SELECT MAX(elevation) AS elevation FROM airports) AS LHS LEFT JOIN airports AS RHS ON (LHS.elevation = RHS.elevation)) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Argentina',)
('Zambia',)
*/

-- Prediction Query
SELECT country FROM airports ORDER BY elevation DESC, airports.apid NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zambia',)
*/