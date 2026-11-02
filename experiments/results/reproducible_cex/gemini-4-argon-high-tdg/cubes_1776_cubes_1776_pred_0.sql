-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (1, 'Engine Overhaul', '2022-01-10', 'Routine check');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (2, 'Brake Replacement', '2022-03-15', 'Urgent');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (101, 2018, 'A', 'Alpha', 'S1', 85.5, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (102, 2020, 'B', 'Beta', 'S2', 92.0, 2);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'Zoe', 'Alpha', 2015, 36);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'Alice', 'Beta', 2016, 37);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3, 'Bob', 'Alpha', 2018, 35);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (4, 'Charlie', 'Gamma', 2012, 38);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5, 'Alice', 'Alpha', 2019, 36);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (6, 'David', 'Beta', 2014, 37);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 1, 101);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (1, 2, 102);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (3, 1, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM technician WHERE (age >= 36 AND age <= 37) ORDER BY name, technician.technician_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('David',)
('Zoe',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE Age = 36 OR Age = 37;

/*
Prediction Result:
('Zoe',)
('Alice',)
('Alice',)
('David',)
*/