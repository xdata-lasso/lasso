-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (1, 'Dan', 'Alpha', 2018, 55);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (2, 'Eve', 'Beta', 2008, 55);
INSERT INTO technician (technician_id, Name, Team, Starting_Year, Age) VALUES (3, 'Frank', 'Gamma', 2000, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT starting_year FROM (SELECT LHS.technician_id AS technician_id, LHS.name AS name, LHS.team AS team, LHS.starting_year AS starting_year, LHS.age AS age, RHS.technician_id AS technician_id_other, RHS.name AS name_other, RHS.starting_year AS starting_year_other, RHS.age AS age_other FROM technician AS LHS INNER JOIN (SELECT technician_id, name, team, starting_year, age, MAX(age) OVER () AS maxage FROM technician) AS RHS ON (LHS.age = RHS.maxage AND LHS.team = RHS.team)) ORDER BY starting_year;

/*
Gold Result:
(2008.0,)
(2018.0,)
*/

-- Prediction Query
SELECT Starting_Year FROM technician ORDER BY Age DESC, technician.technician_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(2018.0,)
*/