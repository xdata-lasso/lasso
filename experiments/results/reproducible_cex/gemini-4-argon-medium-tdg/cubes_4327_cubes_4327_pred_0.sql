-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard join vs mutant joining machine.Machine_ID = repair_assignment.Machine_ID, and tests duplicate preservation (SELECT vs SELECT DISTINCT) and ordering (ASC vs DESC).
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (10, 'RepairX', '2020-01-01', 'Note1');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (20, 'RepairY', '2020-01-02', 'Note2');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (1, 2015, 'A', 'Red', 'S1', 100.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (2, 2016, 'B', 'Blue', 'S2', 200.0, 2);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (99, 2017, 'C', 'Green', 'S3', 300.0, 3);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1.0, 'Zack', 'Alpha', 2010.0, 35);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2.0, 'Alice', 'Beta', 2012.0, 28);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3.0, 'Bob', 'Gamma', 2014.0, 40);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 10, 99);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 20, 99);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 10, 99);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (3, 10, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.machine_id AS machine_id, LHS.making_year AS making_year, LHS.class AS CLASS, LHS.team AS team, LHS.machine_series AS machine_series, LHS.value_points AS value_points, LHS.quality_rank AS quality_rank, RHS.name AS name, RHS.team AS team_other, RHS.starting_year AS starting_year, RHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id_other FROM machine AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) AS RHS ON (LHS.machine_id = RHS.technician_id)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT T3.Name FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID ORDER BY T2.quality_rank, T1.technician_id NULLS LAST, T1.repair_id NULLS LAST, T1.machine_id NULLS LAST, T2.machine_id NULLS LAST, T3.technician_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Zack',)
('Zack',)
('Alice',)
*/