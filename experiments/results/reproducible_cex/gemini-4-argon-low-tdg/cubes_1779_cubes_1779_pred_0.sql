-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (30.0, 'Alice', 'Beta', 2015.0, 40);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (10.0, 'Bob', 'Alpha', 2020.0, 25);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (20.0, 'Charlie', 'Alpha', 2018.0, 35);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5.0, 'David', 'Alpha', 2022.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (15.0, 'Eve', 'Beta', 2019.0, 28);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, starting_year FROM technician ORDER BY team, technician.technician_id NULLS LAST;

/*
Gold Result:
('Alpha', 2022.0)
('Alpha', 2020.0)
('Alpha', 2018.0)
('Beta', 2019.0)
('Beta', 2015.0)
*/

-- Prediction Query
SELECT Team, Starting_Year FROM technician;

/*
Prediction Result:
('Beta', 2015.0)
('Alpha', 2020.0)
('Alpha', 2018.0)
('Alpha', 2022.0)
('Beta', 2019.0)
*/