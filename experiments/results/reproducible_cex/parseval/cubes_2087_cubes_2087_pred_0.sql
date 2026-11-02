-- Schema DDL
CREATE TABLE "routes" ("rid" INTEGER PRIMARY KEY, "alid" INTEGER, "src_apid" INTEGER, "dst_apid" INTEGER, "dst_ap" TEXT(4), "src_ap" TEXT(4), "airline" TEXT(4), "codeshare" TEXT, FOREIGN KEY ("alid") REFERENCES "airlines" ("alid"), FOREIGN KEY ("src_apid") REFERENCES "airports" ("apid"), FOREIGN KEY ("dst_apid") REFERENCES "airports" ("apid"));

CREATE TABLE "airports" ("apid" INTEGER PRIMARY KEY, "name" TEXT, "city" TEXT, "country" TEXT, "x" REAL, "y" REAL, "elevation" INTEGER, "iata" TEXT(3), "icao" TEXT(4));

CREATE TABLE "airlines" ("alid" INTEGER PRIMARY KEY, "name" TEXT, "iata" TEXT(2), "icao" TEXT(3), "callsign" TEXT, "country" TEXT, "active" TEXT(2));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: airports --
INSERT INTO "airports" ("apid", "name", "city", "country", "x", "y", "elevation", "iata", "icao") VALUES (-2147483648, '5k5swwqcgs', '9n8', '4', 249.706432, 99.523333, -734455130, '15f', '8b03');

-- Inserting into table: airlines --
INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (1, 'American Airlines', 'air_93b1cb', 'air_1f4e30', 'air_97a666', 'air_439e94', 'air_e825a0');

INSERT INTO "airlines" ("alid", "name", "iata", "icao", "callsign", "country", "active") VALUES (-2147483647, 'American Airlines', 'air_6c3bc1', 'air_c826d3', 'air_948451', 'air_be5f13', 'air_d87ce8');

-- Inserting into table: routes --
INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (1, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (2, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (3, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (-2147483645, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (4, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (5, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (-2147483642, 1, -2147483648, -2147483648, '21d7', '1a67', NULL, 'rwbbp6luhvd');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (-2147483641, 1, -2147483648, -2147483648, '21d7', '1a67', NULL, 'ilbnp');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (-2147483640, 1, -2147483648, -2147483648, '21d7', '1a67', NULL, 'dposiie5unw');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (6, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (7, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (8, -2147483647, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (9, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (10, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (11, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (12, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (13, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (14, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (15, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (16, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (17, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (18, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (19, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (20, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (21, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (22, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (23, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (24, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (25, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (26, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (27, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (28, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (29, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (30, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (31, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (32, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (33, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (34, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (35, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (36, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (37, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');

INSERT INTO "routes" ("rid", "alid", "src_apid", "dst_apid", "dst_ap", "src_ap", "airline", "codeshare") VALUES (38, 1, -2147483648, -2147483648, 'value', 'value', 'rou_3e13df', 'value');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "LHS"."alid" AS "alid", "LHS"."name" AS "name", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."callsign" AS "callsign", "LHS"."country" AS "country", "LHS"."active" AS "active", "RHS"."airline" AS "airline", "RHS"."n" AS "n" FROM (SELECT "LHS"."alid" AS "alid", "LHS"."name" AS "name", "LHS"."iata" AS "iata", "LHS"."icao" AS "icao", "LHS"."callsign" AS "callsign", "LHS"."country" AS "country", "LHS"."active" AS "active" FROM "airlines" AS "LHS" INNER JOIN (SELECT * FROM "airlines" WHERE ("name" = 'American Airlines')) AS RHS ON (LHS.alid = RHS.alid AND LHS.name = RHS.name AND LHS.iata = RHS.iata AND LHS.icao = RHS.icao AND LHS.callsign = RHS.callsign AND LHS.country = RHS.country AND LHS.active = RHS.active)) AS LHS INNER JOIN (SELECT airline, alid, COUNT(*) AS n FROM routes GROUP BY airline, alid) AS RHS ON (LHS.alid = RHS.alid)) ORDER BY count___;

/*
Gold Result:
(1,)
(3,)
(38,)
*/

-- Prediction Query
SELECT COUNT(*) FROM airlines AS T1 JOIN routes AS T2 ON T1.alid = T2.alid WHERE T1.name = 'American Airlines';

/*
Prediction Result:
(42,)
*/