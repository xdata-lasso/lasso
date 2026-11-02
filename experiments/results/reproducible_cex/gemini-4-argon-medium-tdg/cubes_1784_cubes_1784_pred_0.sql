-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests:
-- 1. ORDER BY name ASC, machine_series ASC NULLS LAST.
-- 2. Handling of NULLs in both name and machine_series (verifying NULLS FIRST vs NULLS LAST on both sort keys).
-- 3. Tie-breaking on identical technician names with different machine_series (and vice versa).
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (1, 'R1', '2022-01-01', 'N1');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (1, 2020, 'C1', 'T1', 'Series_B', 10.0, 1);
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (2, 2020, 'C1', 'T1', 'Series_A', 20.0, 2);
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (3, 2020, 'C1', 'T1', NULL, 30.0, 3);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (10.0, 'Charlie', 'T1', 2015.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (20.0, 'Alice', 'T1', 2016.0, 25);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (30.0, NULL, 'T1', 2017.0, 40);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (10, 1, 1);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (10, 1, 2);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (20, 1, 3);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (20, 1, 1);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (20, 1, 2);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (30, 1, 2);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (30, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, machine_series FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team_other, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM technician AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.repair_id AS repair_id, LHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM repair_assignment AS LHS INNER JOIN machine AS RHS ON (LHS.machine_id = RHS.machine_id)) AS RHS ON (LHS.technician_id = RHS.technician_id)) ORDER BY name, machine_series NULLS LAST;

/*
Gold Result:
(None, 'Series_A')
(None, None)
('Alice', 'Series_A')
('Alice', 'Series_B')
('Alice', None)
('Charlie', 'Series_A')
('Charlie', 'Series_B')
*/

-- Prediction Query
SELECT T3.Name, T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID;

/*
Prediction Result:
('Charlie', 'Series_B')
('Charlie', 'Series_A')
('Alice', None)
('Alice', 'Series_B')
('Alice', 'Series_A')
(None, 'Series_A')
(None, None)
*/