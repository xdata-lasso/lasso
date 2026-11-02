-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "repair" ("repair_ID", "name", "Launch_Date", "Notes") VALUES (1, 'R1', '2020-01-01', 'Note');
INSERT INTO "machine" ("Machine_ID", "Making_Year", "Class", "Team", "Machine_series", "value_points", "quality_rank") VALUES (1, 2020, 'C1', 'T1', 'S1', 10.0, 1);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1.0, 'Tech1', 'T1', 2019.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (2.0, 'Z_Tech', 'T1', 2019.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (3.0, 'A_Tech', 'T1', 2019.0, 30);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (NULL, 'Null_Tech', 'T1', 2019.0, 30);
INSERT INTO "repair_assignment" ("technician_id", "repair_ID", "Machine_ID") VALUES (1, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM technician AS LHS WHERE NOT EXISTS(SELECT 1 FROM repair_assignment AS RHS WHERE (LHS.technician_id = RHS.technician_id))) ORDER BY name;

/*
Gold Result:
('A_Tech',)
('Null_Tech',)
('Z_Tech',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE NOT technician_id IN (SELECT technician_id FROM repair_assignment);

/*
Prediction Result:
('Z_Tech',)
('A_Tech',)
*/