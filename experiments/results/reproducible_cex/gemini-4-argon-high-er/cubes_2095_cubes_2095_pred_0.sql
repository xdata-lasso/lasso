-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (1, 'Airport A', 'City A', 'A', 0.0, 0.0, 200, 'AAA', 'AAAA');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (2, 'Airport B', 'City B', 'B', 0.0, 0.0, 100, 'BBB', 'BBBB');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (3, 'Airport C', 'City C', NULL, 0.0, 0.0, 100, 'CCC', 'CCCC');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanelevation AS avg_elevation_, country FROM (SELECT country, AVG(elevation) AS meanelevation FROM airports GROUP BY country) ORDER BY avg_elevation_, country NULLS LAST;

/*
Gold Result:
(100.0, 'B')
(100.0, None)
(200.0, 'A')
*/

-- Prediction Query
SELECT AVG(elevation), country FROM airports GROUP BY country;

/*
Prediction Result:
(100.0, None)
(200.0, 'A')
(100.0, 'B')
*/