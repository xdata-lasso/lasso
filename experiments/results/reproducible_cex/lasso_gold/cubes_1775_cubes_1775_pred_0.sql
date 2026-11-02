-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1081, 1082, 'land', 'development', 'woman', 1083.5, 1084);
INSERT INTO "machine" ("machine_id", "making_year", "class", "team", "machine_series", "value_points", "quality_rank") VALUES (1089, 1090, 'account', 'avoid', 'second', 1091.5, 1092);
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1085, 'Monica Harris', 'forget', 'Yet practice just military building different.');
INSERT INTO "repair" ("repair_id", "name", "launch_date", "notes") VALUES (1093, 'Crystal Whitehead', 'trade', 'Audience draw protect Democrat car very.');
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1086, 'Kevin Hall', 'discussion', 1087.5, 1088);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1094, 'Kevin Hall', 'own', 1095.5, 1089);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1096.5, 'Kevin Hall', 'own', 1095.5, 1089);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1086, 1085, 1081);
INSERT INTO "repair_assignment" ("technician_id", "repair_id", "machine_id") VALUES (1094, 1093, 1089);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Kevin Hall', 1)
('Kevin Hall', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
('Kevin Hall', 2)
*/