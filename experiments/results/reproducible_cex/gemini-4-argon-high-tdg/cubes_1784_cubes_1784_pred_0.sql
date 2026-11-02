-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (1, 'Repair_One', '2023-01-01', 'Note A');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (2, 'Repair_Two', '2023-02-01', 'Note B');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (3, 'Repair_Unassigned', '2023-03-01', 'Note C');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (1, 2018, 'Class_A', 'Team_Alpha', 'Series_2', 100.5, 2);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (2, 2019, 'Class_B', 'Team_Beta', 'Series_1', 200.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (3, 2020, 'Class_C', 'Team_Gamma', 'Series_3', 150.0, 3);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (4, 2021, 'Class_D', 'Team_Shared', 'Series_Unassigned', 300.0, 4);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'Zack', 'Team_Z', 2015.0, 35);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'Alice', 'Team_X', 2016.0, 28);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3, 'Bob', 'Team_Shared', 2017.0, 40);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 2, 3);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 1, 1);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, machine_series FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team_other, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM technician AS LHS INNER JOIN (SELECT LHS.technician_id AS technician_id, LHS.repair_id AS repair_id, LHS.machine_id AS machine_id, RHS.making_year AS making_year, RHS.class AS CLASS, RHS.team AS team, RHS.machine_series AS machine_series, RHS.value_points AS value_points, RHS.quality_rank AS quality_rank FROM repair_assignment AS LHS INNER JOIN machine AS RHS ON (LHS.machine_id = RHS.machine_id)) AS RHS ON (LHS.technician_id = RHS.technician_id)) ORDER BY name, machine_series NULLS LAST;

/*
Gold Result:
('Alice', 'Series_1')
('Alice', 'Series_2')
('Zack', 'Series_3')
*/

-- Prediction Query
SELECT T3.Name, T2.Machine_series FROM repair_assignment AS T1 JOIN machine AS T2 ON T1.machine_id = T2.machine_id JOIN technician AS T3 ON T1.technician_ID = T3.technician_ID;

/*
Prediction Result:
('Zack', 'Series_3')
('Alice', 'Series_2')
('Alice', 'Series_1')
*/