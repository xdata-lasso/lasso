-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (1, 'Fix A', '2020-01-01', 'Note 1');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (2, 'Fix B', '2020-01-02', 'Note 2');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (10, 2015, 'C1', 'T1', 'S1', 100.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (20, 2016, 'C2', 'T2', 'S2', 200.0, 2);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1.0, 'Alice', 'Alpha', 2018.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2.0, 'Alice', 'Beta', 2019.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3.0, 'Alice', 'Gamma', 2020.0, 40);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (4.0, 'Bob', 'Alpha', 2017.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5.0, 'Charlie', 'Delta', 2021.0, 25);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 1, 10);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 1, 10);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 2, 20);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (3, 1, 20);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (4, 1, 10);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (4, 2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 2)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
('Alice', 4)
('Bob', 2)
*/