-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO technician (technician_id, name, team, starting_year, age) VALUES (1.0, NULL, NULL, 1.0, 1), (0.0, NULL, 'default2', 0.0, NULL), (25000.0, NULL, 'default1', NULL, NULL), (50000.0, 'default2', NULL, 1.0, 1), (75000.0, 'default2', 'default1', 0.0, 1), (100000.0, 'default1', 'default1', 0.0, 0);
INSERT INTO machine (machine_id, making_year, class, team, machine_series, value_points, quality_rank) VALUES (1, NULL, 'default1', 'default1', NULL, 1.0, 1), (0, 1, 'default2', NULL, 'default1', NULL, 0);
INSERT INTO repair (repair_id, name, launch_date, notes) VALUES (0, 'default2', NULL, 'default1'), (1, NULL, 'default2', 'default2'), (2, 'default2', 'default2', 'default1'), (3, 'default2', 'default1', 'default1'), (4, 'default2', NULL, NULL);
INSERT INTO repair_assignment (technician_id, repair_id, machine_id) VALUES (0.0, 3, 1), (0.0, 4, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, machine_series FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team_other, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM technician AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.repair_id AS repair_id, LHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM repair_assignment AS LHS INNER JOIN machine AS RHS ON (LHS.machine_id = RHS.machine_id)) AS RHS ON (LHS.technician_id = RHS.technician_id)) ORDER BY name, machine_series NULLS LAST;

/*
Gold Result:
(None, 'default1')
(None, None)
*/

-- Prediction Query
SELECT T3.Name, T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID;

/*
Prediction Result:
(None, None)
(None, 'default1')
*/