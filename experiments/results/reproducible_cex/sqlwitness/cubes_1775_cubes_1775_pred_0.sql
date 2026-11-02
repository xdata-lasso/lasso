-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO technician (technician_id, name, team, starting_year, age) VALUES (0.0, NULL, 'default2', NULL, NULL), (1.0, NULL, 'default1', NULL, 0);
INSERT INTO machine (machine_id, making_year, class, team, machine_series, value_points, quality_rank) VALUES (1, 1, NULL, NULL, 'default1', 1.0, NULL), (0, 1, 'default1', 'default2', 'default2', 1.0, NULL), (2, 0, 'default1', 'default1', NULL, 0.0, 0), (3, 0, 'default2', 'default1', 'default2', 1.0, 1), (4, 1, 'default1', NULL, 'default2', 0.0, 0), (5, NULL, 'default1', NULL, NULL, 0.0, NULL), (6, NULL, 'default2', NULL, 'default2', NULL, NULL), (7, NULL, 'default2', 'default1', NULL, NULL, 1), (8, 1, 'default1', 'default1', NULL, 0.0, NULL), (9, 0, 'default2', 'default2', 'default2', 0.0, 1), (10, NULL, 'default2', 'default1', NULL, NULL, 1);
INSERT INTO repair (repair_id, name, launch_date, notes) VALUES (0, 'default2', 'default1', 'default1'), (1, 'default1', NULL, 'default2'), (2, 'default1', 'default1', 'default2'), (3, 'default2', NULL, 'default2'), (4, NULL, NULL, 'default2'), (5, 'default1', NULL, NULL), (6, NULL, 'default2', NULL), (7, 'default1', 'default2', NULL), (8, NULL, 'default2', NULL), (9, 'default1', 'default1', 'default1'), (10, NULL, 'default1', 'default2');
INSERT INTO repair_assignment (technician_id, repair_id, machine_id) VALUES (1.0, 6, 8), (0.0, 7, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
(None, 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
(None, 2)
*/