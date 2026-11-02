-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO technician (technician_id, name, team, starting_year, age) VALUES (2.0, 'default1', NULL, 2.0, 2), (1.0, NULL, 'default2', 1.0, 1), (0.0, 'default2', 'default1', 2.0, NULL);
INSERT INTO machine (machine_id, making_year, class, team, machine_series, value_points, quality_rank) VALUES (0, 2, NULL, 'default1', 'default1', NULL, 1), (1, 0, 'default1', NULL, 'default2', NULL, 1), (2, 2, NULL, NULL, 'default2', 1.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM technician AS LHS WHERE NOT EXISTS(SELECT 1 FROM repair_assignment AS RHS WHERE (LHS.technician_id = RHS.technician_id))) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE NOT technician_id IN (SELECT technician_id FROM repair_assignment);

/*
Prediction Result:
('default1',)
(None,)
('default2',)
*/