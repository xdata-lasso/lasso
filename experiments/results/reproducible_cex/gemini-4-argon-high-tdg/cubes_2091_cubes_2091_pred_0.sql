-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Vienna Intl', 'Vienna', 'Austria', 48.11, 16.56, 600, 'VIE', 'LOWW');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Salzburg Airport', 'Salzburg', 'Austria', 47.79, 13.00, 1411, 'SZG', 'LOWS');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Innsbruck Airport', 'Innsbruck', 'Austria', 47.26, 11.34, 1906, 'INN', 'LOWI');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (4, 'Toronto Pearson', 'Toronto', 'Canada', 43.67, -79.63, 569, 'YYZ', 'CYYZ');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (5, 'Billy Bishop', 'Toronto', 'Canada', 43.62, -79.39, 252, NULL, 'CYTZ');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (6, 'Guarulhos', 'Sao Paulo', 'Brazil', -23.43, -46.47, 2459, 'GRU', 'SBGR');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (7, 'Congonhas', 'Sao Paulo', 'Brazil', -23.62, -46.65, 2631, 'CGH', NULL);
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (8, 'Unknown Base 1', NULL, NULL, 0.0, 0.0, 0, NULL, NULL);
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (9, 'Unknown Base 2', 'Mystery', NULL, 10.0, 10.0, -50, 'UNK', 'XXXX');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'JFK Intl', 'New York', 'USA', 40.63, -73.77, 13, 'JFK', 'KJFK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airports GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'USA')
(2, 'Brazil')
(2, 'Canada')
(2, None)
(3, 'Austria')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airports GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST;

/*
Prediction Result:
(3, 'Austria')
(2, 'Brazil')
(2, 'Canada')
(2, None)
(1, 'USA')
*/