-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (1, 'Overhaul', '2020-01-15', 'Urgent');
INSERT INTO repair (repair_ID, name, Launch_Date, Notes) VALUES (2, 'Calibration', '2021-06-10', 'Routine');
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (1, 2018, 'Heavy', 'Zeta', 'S1', 95.5, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (2, 2019, 'Light', 'Beta', 'S2', 80.0, 2);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (10, 'Alice', 'Beta', 2010.0, 25);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'Zack', 'Beta', 2020.0, 50);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (100, 'Bob', 'Alpha', 2015.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5, 'Charlie', 'Alpha', 2015.0, 40);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'Diana', 'Alpha', 2022.0, 45);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (10, 1, 1);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (10, 2, 2);
INSERT INTO repair_assignment (technician_id, repair_ID, Machine_ID) VALUES (2, 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, starting_year FROM technician ORDER BY team, technician.technician_id NULLS LAST;

/*
Gold Result:
('Alpha', 2022.0)
('Alpha', 2015.0)
('Alpha', 2015.0)
('Beta', 2020.0)
('Beta', 2010.0)
*/

-- Prediction Query
SELECT Team, Starting_Year FROM technician;

/*
Prediction Result:
('Beta', 2010.0)
('Beta', 2020.0)
('Alpha', 2015.0)
('Alpha', 2015.0)
('Alpha', 2022.0)
*/