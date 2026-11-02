-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (1, 'Overhaul', '2020-01-10', 'Routine');
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (2, 'Calibration', '2020-05-15', 'Urgent');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (10, 2015, 'A', 'NYY', 'X1', 95.5, 1);
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (20, 2018, 'B', 'BOS', 'X2', 80.0, 2);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1, 'Zack', 'BOS', 2015.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2, 'Alice', 'NYY', 2012.0, 25);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (3, 'Bob', 'LAD', 2018.0, 40);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (4, 'Bob', 'CHC', 2010.0, 35);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 1, 10);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 2, 10);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (2, 1, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "technician" WHERE ("team" <> 'NYY') ORDER BY name, technician.technician_id NULLS LAST;

/*
Gold Result:
('Bob',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE Team <> 'NYY';

/*
Prediction Result:
('Zack',)
('Bob',)
('Bob',)
*/