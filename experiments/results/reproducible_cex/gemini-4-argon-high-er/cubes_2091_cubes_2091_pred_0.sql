-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO airports (apid, country) VALUES (1, 'A');
INSERT INTO airports (apid, country) VALUES (2, 'B');
INSERT INTO airports (apid, country) VALUES (3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, country FROM (SELECT country, COUNT(*) AS n FROM airports GROUP BY country) ORDER BY count___, country NULLS LAST;

/*
Gold Result:
(1, 'A')
(2, 'B')
*/

-- Prediction Query
SELECT COUNT(*), country FROM airports GROUP BY country ORDER BY COUNT(*) DESC, country NULLS LAST;

/*
Prediction Result:
(2, 'B')
(1, 'A')
*/