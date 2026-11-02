-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (out of order insertion), duplicate names (SELECT vs SELECT DISTINCT), NULL names, NULL PK (technician_id), and inverse correlation between technician_id and Age/Starting_Year/Team to catch incorrect ORDER BY column mutations.
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (10.0, 'Charlie', 'Alpha', 2022.0, 25);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2.0, 'Alice', 'Zeta', 2020.0, 40);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (5.0, 'Alice', 'Beta', 2018.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1.0, 'Bob', 'Gamma', 2021.0, 50);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (NULL, 'Bob', 'Delta', 2015.0, 20);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (8.0, NULL, 'Omega', 2019.0, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM technician ORDER BY name, technician.technician_id NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Bob',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT Name FROM technician ORDER BY Age ASC, technician.technician_id NULLS LAST;

/*
Prediction Result:
('Bob',)
('Charlie',)
('Alice',)
(None,)
('Alice',)
('Bob',)
*/