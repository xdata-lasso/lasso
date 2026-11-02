-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1063, 1064, 'could', 'movement', 'while', 1065.5, 1066);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1079, 1080, 'company', 'evidence', 'news', 1081.5, 1082);
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1067, 'Mario Skinner', 'politics', 'Check several much single morning.');
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1083, 'Jenny Lewis', 'notice', 'Require human public health tonight.');
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1075, NULL, NULL, NULL);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1068, 'Fred Smith', 'woman', 1069.5, 1070);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1084, 'David Brown', 'against', 1085.5, 1086);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1068, 1067, 1063);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1068, 1075, 1063);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1084, 1083, 1079);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, machine_series FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team_other, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM technician AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.repair_id AS repair_id, LHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM repair_assignment AS LHS INNER JOIN machine AS RHS ON (LHS.machine_id = RHS.machine_id)) AS RHS ON (LHS.technician_id = RHS.technician_id)) ORDER BY name, machine_series NULLS LAST;

/*
Gold Result:
('David Brown', 'news')
('Fred Smith', 'while')
('Fred Smith', 'while')
*/

-- Prediction Query
SELECT T3.Name, T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID;

/*
Prediction Result:
('Fred Smith', 'while')
('Fred Smith', 'while')
('David Brown', 'news')
*/