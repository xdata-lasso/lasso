-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'T1', 'Zeta', 2020, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'T2', 'Zeta', 2020, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3, 'T3', 'Beta', 2020, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (4, 'T4', 'Beta', 2020, 30);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (5, 'T5', 'Alpha', 2020, 30);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (101, 2020, 'B', 'Alpha', 'S2', 50.0, 2);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (102, 2020, 'B', 'Alpha', 'S2', 50.0, 2);
INSERT INTO machine (Machine_ID, Making_Year, Class, Team, Machine_series, value_points, quality_rank) VALUES (103, 2020, 'B', 'Alpha', 'S2', 50.0, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team FROM (SELECT LHS.team AS team, LHS.n AS n FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team) AS LHS INNER JOIN (SELECT MAX(n) AS maxn FROM (SELECT team, COUNT(*) AS n FROM technician GROUP BY team)) AS RHS ON (LHS.n = RHS.maxn)) ORDER BY team;

/*
Gold Result:
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT Team FROM technician GROUP BY Team ORDER BY COUNT(*) DESC, Team NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/