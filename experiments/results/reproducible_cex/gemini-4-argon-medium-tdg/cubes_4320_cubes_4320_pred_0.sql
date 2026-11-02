-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for the maximum count (kills LIMIT 1 mutants), ORDER BY team direction (Zeta inserted before Alpha), and decoy data in `machine` table (kills mutants querying machine.Team instead of technician.Team).
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (1, 2020, 'A', 'Beta', 'S1', 10.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (2, 2020, 'A', 'Beta', 'S1', 10.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (3, 2020, 'A', 'Beta', 'S1', 10.0, 1);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (4, 2020, 'A', 'Beta', 'S1', 10.0, 1);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1.0, 'T1', 'Zeta', 2015.0, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2.0, 'T2', 'Zeta', 2016.0, 31);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3.0, 'T3', 'Zeta', 2017.0, 32);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (4.0, 'T4', 'Beta', 2018.0, 25);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5.0, 'T5', 'Alpha', 2019.0, 40);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (6.0, 'T6', 'Alpha', 2020.0, 41);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (7.0, 'T7', 'Alpha', 2021.0, 42);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT LHS.team AS team, LHS.n AS n FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team) AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team)) AS RHS ON (LHS.n = RHS.maxn)) ORDER BY team;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT Team FROM technician GROUP BY Team ORDER BY COUNT(*) DESC, Team NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/