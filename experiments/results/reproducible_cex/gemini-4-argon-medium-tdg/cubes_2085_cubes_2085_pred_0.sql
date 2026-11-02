-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary conditions for COUNT(*) > 2 (counts of 1, 2, 3, and 4) and ORDER BY city (inserted out of alphabetical order).
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Zulu1', 'Zulu', 'CountryA', 10.0, 20.0, 100, 'ZU1', 'ZUL1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Zulu2', 'Zulu', 'CountryA', 10.1, 20.1, 100, 'ZU2', 'ZUL2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Zulu3', 'Zulu', 'CountryA', 10.2, 20.2, 100, 'ZU3', 'ZUL3');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Alpha1', 'Alpha', 'CountryB', 30.0, 40.0, 200, 'AL1', 'ALP1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Alpha2', 'Alpha', 'CountryB', 30.1, 40.1, 200, 'AL2', 'ALP2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Alpha3', 'Alpha', 'CountryB', 30.2, 40.2, 200, 'AL3', 'ALP3');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Alpha4', 'Alpha', 'CountryB', 30.3, 40.3, 200, 'AL4', 'ALP4');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Bravo1', 'Bravo', 'CountryC', 50.0, 60.0, 300, 'BR1', 'BRA1');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (9, 'Bravo2', 'Bravo', 'CountryC', 50.1, 60.1, 300, 'BR2', 'BRA2');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'Charlie1', 'Charlie', 'CountryD', 70.0, 80.0, 400, 'CH1', 'CHA1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM (SELECT city, COUNT(*) AS n FROM airports GROUP BY city) WHERE (n > 2) ORDER BY city;

/*
Gold Result:
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT city FROM airports GROUP BY city HAVING COUNT(*) > 2 ORDER BY COUNT(*), city NULLS LAST;

/*
Prediction Result:
('Zulu',)
('Alpha',)
*/