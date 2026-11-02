-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Unassigned technician (tech 4) to kill LEFT JOIN vs INNER JOIN mutants.
-- 2. Two technicians with the same Name and same Age (techs 1 and 2) to kill GROUP BY technician_id vs GROUP BY age, name mutants.
-- 3. Technician with the same Name ("Alice") but different Age (tech 3 vs techs 1,2) to kill GROUP BY name only AND to test secondary ORDER BY count___ ASC vs DESC.
-- 4. Duplicate repair_ID and Machine_ID across assignments to kill COUNT(DISTINCT repair_ID) or COUNT(DISTINCT Machine_ID) vs COUNT(*) mutants.
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (10, 'Fix A', '2020-01-01', 'Note 1');
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (20, 'Fix B', '2020-01-02', 'Note 2');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (100, 2015, 'A', 'Red', 'S1', 10.5, 1);
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (200, 2016, 'B', 'Blue', 'S2', 20.0, 2);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1, 'Alice', 'Red', 2018, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2, 'Alice', 'Blue', 2019, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (3, 'Alice', 'Green', 2020, 40);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (4, 'Bob', 'Yellow', 2021, 25);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 10, 100);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 10, 200);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (2, 10, 100);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (3, 20, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
('Alice', 4)
*/