-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (101, 'JFK Airport', 'New York', 'United States', -73.77, 40.64, 13, 'JFK', 'KJFK');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (102, 'LAX Airport', 'Los Angeles', 'United States', -118.40, 33.94, 125, 'LAX', 'KLAX');
INSERT INTO airports (apid, name, city, country, x, y, elevation, iata, icao) VALUES (103, 'ORD Airport', 'Chicago', 'United States', -87.90, 41.97, 672, 'ORD', 'KORD');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (1, 'American Airlines', 'AA', 'AAL', 'AMERICAN', 'United States', 'Y');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (2, 'American Airlines', 'AA', 'AAL', 'AMERICAN', 'Canada', 'N');
INSERT INTO airlines (alid, name, iata, icao, callsign, country, active) VALUES (3, 'Delta Air Lines', 'DL', 'DAL', 'DELTA', 'United States', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (1, 1, 101, 102, 'LAX', 'JFK', 'AA', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (2, 1, 102, 103, 'ORD', 'LAX', 'AA', 'N');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (3, 1, 103, 101, 'JFK', 'ORD', 'AA', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (4, 2, 101, 103, 'ORD', 'JFK', 'AA', 'N');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (5, 3, 101, 102, 'LAX', 'JFK', 'DL', 'Y');
INSERT INTO routes (rid, alid, src_apid, dst_apid, dst_ap, src_ap, airline, codeshare) VALUES (6, 3, 102, 101, 'JFK', 'LAX', 'DL', 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "LHS"."alid" AS "alid", "LHS"."name" AS "name", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."callsign" AS "callsign", "LHS"."country" AS "country", "LHS"."active" AS "active", "RHS"."airline" AS "airline", "RHS"."n" AS "n" FROM (SELECT "LHS"."alid" AS "alid", "LHS"."name" AS "name", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."callsign" AS "callsign", "LHS"."country" AS "country", "LHS"."active" AS "active" FROM "airlines" AS "LHS" INNER JOIN (SELECT * FROM "airlines" WHERE ("name" = 'American Airlines')) AS RHS ON (LHS.alid = RHS.alid AND LHS.name = RHS.name AND LHS.iata = RHS.iata AND LHS.icao = RHS.icao AND LHS.callsign = RHS.callsign AND LHS.country = RHS.country AND LHS.active = RHS.active)) AS LHS INNER JOIN (SELECT airline, alid, COUNT(*) AS n FROM routes GROUP BY airline, alid) AS RHS ON (LHS.alid = RHS.alid)) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM airlines AS T1 JOIN routes AS T2 ON T1.alid = T2.alid WHERE T1.name = 'American Airlines';

/*
Prediction Result:
(4,)
*/