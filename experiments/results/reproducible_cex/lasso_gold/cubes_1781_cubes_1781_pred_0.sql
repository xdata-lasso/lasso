-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1024.5, 'Stacey Ward', 'capital', 1025.5, 1026);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1027.5, 'Andrew Stevens', 'themselves', 1026.5, 1027);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM technician AS LHS WHERE NOT EXISTS(SELECT 1 FROM repair_assignment AS RHS WHERE (LHS.technician_id = RHS.technician_id))) ORDER BY name;

/*
Gold Result:
('Andrew Stevens',)
('Stacey Ward',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE NOT technician_id IN (SELECT technician_id FROM repair_assignment);

/*
Prediction Result:
('Stacey Ward',)
('Andrew Stevens',)
*/