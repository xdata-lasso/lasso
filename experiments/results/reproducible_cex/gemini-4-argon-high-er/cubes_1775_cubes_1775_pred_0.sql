-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (1, 'Fix', '2020-01-01', 'None');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (1, 2015, 'A', 'T1', 'S1', 10.0, 1);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1, 'Alice', 'T1', 2018, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2, 'Alice', 'T1', 2019, 40);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 1, 1);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT age, name, COUNT(*) AS n FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.repair_id AS repair_id, RHS.machine_id AS machine_id FROM technician AS LHS INNER JOIN repair_assignment AS RHS ON (LHS.technician_id = RHS.technician_id)) GROUP BY age, name) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 1)
*/

-- Prediction Query
SELECT T2.Name, COUNT(*) FROM repair_assignment AS T1 JOIN technician AS T2 ON T1.technician_ID = T2.technician_ID GROUP BY T2.Name;

/*
Prediction Result:
('Alice', 2)
*/