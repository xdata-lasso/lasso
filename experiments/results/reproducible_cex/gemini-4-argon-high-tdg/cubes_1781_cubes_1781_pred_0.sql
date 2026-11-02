-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (1, 'Engine Overhaul', '2021-01-10', 'Major');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (2, 'Belt Replacement', '2021-02-15', 'Minor');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (3, 'Sensor Calibration', '2021-03-20', 'Routine');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (1, 2015, 'Heavy', 'Alpha', 'S1', 100.5, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (2, 2018, 'Light', 'Beta', 'S2', 85.0, 2);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (3, 2020, 'Medium', 'Gamma', 'S3', 92.0, 3);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'Zoe', 'Alpha', 2010.0, 25);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'Bob', 'Beta', 2020.0, 45);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3, 'Alice', 'Gamma', 2015.0, 35);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (4, 'Charlie', 'Alpha', 2012.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5, 'David', 'Delta', 2018.0, 28);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (4, 1, 2);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (4, 3, 3);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (5, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM technician AS LHS WHERE NOT EXISTS(SELECT 1 FROM repair_assignment AS RHS WHERE (LHS.technician_id = RHS.technician_id))) ORDER BY name;

/*
Gold Result:
('Alice',)
('Bob',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE NOT technician_id IN (SELECT technician_id FROM repair_assignment);

/*
Prediction Result:
('Zoe',)
('Bob',)
('Alice',)
*/