-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO technician (technician_id, name, team, starting_year, age) VALUES (38.0, 'default1', NULL, 0.0, 37), (1.0, NULL, NULL, 37.0, 1), (35.0, NULL, 'default2', 0.0, 1), (37.0, NULL, 'default2', 37.0, 35), (0.0, NULL, 'default1', 1.0, 35), (36.0, 'default2', 'default2', 38.0, 37), (33333.333333, 'default1', NULL, 1.0, 35), (66666.666667, 'default2', 'default2', 36.0, 37), (100000.0, NULL, 'default1', 0.0, 37);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM technician WHERE (age >= 36 AND age <= 37) ORDER BY name, technician.technician_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE Age = 36 OR Age = 37;

/*
Prediction Result:
('default1',)
('default2',)
('default2',)
(None,)
*/