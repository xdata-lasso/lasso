-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: technician --
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (582.588439, '5k5swwqcgsk', 'tec_ba3cf9', 572.766956, 1610062532);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (475.173408, 'u7', 'tec_ba3cf9', 328.996339, 1744686505);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (483.665643, 'hria2ypuzhs', 'tec_ba3cf9', 663.049759, 906324270);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (944.247544, 'p', 'tec_dced9b', 503.083789, -1659388584);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (855.355181, 'tti', 'tec_dced9b', 182.319045, -1257178728);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (787.938887, 'dpos', 'tec_dced9b', 133.007885, -1823627488);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (327.753528, '9000t5c4ec', 'tec_ba3cf9', 128.76421, -1683203397);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (218.301157, 'e376nium52', 'tec_ba3cf9', 816.814398, -443340271);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (992.733505, 'uo4nrqrofqy', 'tec_ba3cf9', 242.260296, 1884179925);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (162.04354, 'bbp02eut', 'tec_dced9b', 186.190286, 1673584235);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (174.140432, '1', 'tec_dced9b', 982.938576, 274769912);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (741.842896, 'oo3o9', 'tec_dced9b', 111.926013, 1178636309);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (176.308171, 'x14ji7zwau2d', NULL, 845.831524, -511185946);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (262.105498, '3pyu78d99r', NULL, 182.777264, -904834265);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (419.361606, 'yp5qi2rk', NULL, 811.601922, -705985602);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (604.643336, 'x58pz0f8jeg', NULL, 712.084197, -283454505);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (390.34832, '9uxj4hwbdv', NULL, 185.427628, 1581736075);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (439.200238, 'dqwn', NULL, 250.856497, 555413010);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (668.309685, 'hncprjtu0dz', 'tec_ba3cf9', 521.610309, -1748371085);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (94.390081, 'n2f3dqv0g', 'tec_ba3cf9', 790.551139, 1382410067);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (879.800692, '8ozk3zbil', 'tec_ba3cf9', 728.712934, 638024588);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (692.775559, 'ck6ah0', 'tec_dced9b', 92.94508, -1520489792);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (346.706184, 'q7x', 'tec_dced9b', 21.129657, -541746689);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (584.342044, 'yfdrz', 'tec_dced9b', 753.351134, 61479715);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (130.468488, 'jai', 'tec_ba3cf9', 906.609226, 1360271423);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (488.601669, 'grgj', 'tec_ba3cf9', 54.980195, -458359144);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (639.801051, 'f', 'tec_ba3cf9', 100.07927, -1696173285);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (127.371696, 'tsj3ayxp1q4', 'tec_dced9b', 457.141778, -1538707438);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (774.445116, 'den8c68x', 'tec_dced9b', 897.348977, 1774087382);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (13.875982, 'x', 'tec_dced9b', 516.027628, -1762140823);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (819.265503, '1of77p', 'tec_ba3cf9', 398.637058, 1992637800);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (308.935851, 't', 'tec_ba3cf9', 695.452114, -1284905200);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (102.360106, '2g0v5q8qd', 'tec_ba3cf9', 632.482455, -1139855872);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (432.865904, '2278', 'tec_dced9b', 494.537964, 2004147439);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (338.933701, 'ptt', 'tec_dced9b', 107.390057, 1467355421);

INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (217.602841, 'u5zi', 'tec_dced9b', 464.719657, 1944978593);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT LHS.team AS team, LHS.n AS n FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team) AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team)) AS RHS ON (LHS.n = RHS.maxn)) ORDER BY team;

/*
Gold Result:
('tec_ba3cf9',)
('tec_dced9b',)
*/

-- Prediction Query
SELECT Team FROM technician GROUP BY Team ORDER BY COUNT(*) DESC, Team NULLS LAST LIMIT 1;

/*
Prediction Result:
('tec_ba3cf9',)
*/