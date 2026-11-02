-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (1, 'Fix A', '2020-01-01', 'Note 1');
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (2, 'Fix B', '2021-01-01', 'Note 2');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (1, 2015, 'A', 'Red', 'S1', 100.0, 1);
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (2, 2018, 'B', 'Blue', 'S2', 200.0, 2);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1, 'Zack', 'Red', 2010, 45);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2, 'Alice', 'Blue', 2019, 25);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (3, 'Alice', 'Green', 2015, 35);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (4, 'Bob', 'Red', 2012, 40);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (4, 1, 1);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (4, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM technician AS LHS WHERE NOT EXISTS(SELECT 1 FROM repair_assignment AS RHS WHERE (LHS.technician_id = RHS.technician_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE NOT technician_id IN (SELECT technician_id FROM repair_assignment);

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
*/