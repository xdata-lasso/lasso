-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1062, 1063, 'claim', 'hour', 'sound', 1064.5, 1065);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1078, 1079, 'land', 'development', 'woman', 1080.5, 1081);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1069, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1077, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1085, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1066, 'Troy Nielsen', 'why', 'Out major born.');
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1082, 'Monica Harris', 'forget', 'Yet practice just military building different.');
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1074, NULL, NULL, NULL);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1062, 'William Roman', 'education', 1067.5, 1068);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1078, 'Kevin Hall', 'discussion', 1083.5, 1084);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1062, 1066, 1069);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1062, 1074, 1077);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1078, 1082, 1085);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.machine_id AS machine_id, LHS.making_year AS making_year, LHS.class AS CLASS, LHS.team AS team, LHS.machine_series AS machine_series, LHS.value_points AS value_points, LHS.quality_rank AS quality_rank, RHS.name AS name, RHS.team AS team_other, RHS.starting_year AS starting_year, RHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id_other FROM machine AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) AS RHS ON (LHS.machine_id = RHS.technician_id)) ORDER BY name;

/*
Gold Result:
('Kevin Hall',)
('William Roman',)
('William Roman',)
*/

-- Prediction Query
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID ORDER BY T2.quality_rank, T1.technician_id NULLS LAST, T1.repair_id NULLS LAST, T1.machine_id NULLS LAST, T2.machine_id NULLS LAST, T3.technician_id NULLS LAST;

/*
Prediction Result:
('William Roman',)
('William Roman',)
('Kevin Hall',)
*/