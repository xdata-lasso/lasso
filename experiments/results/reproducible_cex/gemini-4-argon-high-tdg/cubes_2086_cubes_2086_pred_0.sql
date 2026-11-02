-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (1, 'RusLine', '7R', 'RLU', 'RUSLINE', 'russia', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (2, 'Rossiya', 'FV', 'SDM', 'ROSSIYA', 'Russian Federation', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (3, 'Ural Airlines', 'U6', 'SVR', 'SVERDLOVSK', 'Russia ', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (4, 'Delta', 'DL', 'DAL', 'DELTA', 'USA', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (5, 'Null Country Air', 'NC', 'NCA', 'NULLAIR', NULL, 'N');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (10, 'Domodedovo', 'Moscow', 'Russia', 55.41, 37.90, 588, 'DME', 'UUDD');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "country", COUNT(*) AS "n" FROM (SELECT * FROM "airlines" WHERE ("country" = 'Russia')) GROUP BY country) ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM airlines WHERE country = 'Russia';

/*
Prediction Result:
(0,)
*/