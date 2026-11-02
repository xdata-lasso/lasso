-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO technician (technician_id, name, team, starting_year, age) VALUES (1.0, 'CWS', 'CLE', 1.0, NULL), (0.0, 'CWS', 'CLE', 1.0, NULL), (2.0, 'CLE', 'CWS', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "starting_year" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "technician" WHERE ("team" <> 'CLE' AND "team" = 'CWS')) ORDER BY technician_id) LIMIT 1);

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT Starting_Year FROM technician WHERE Team = 'CLE' INTERSECT SELECT Starting_Year FROM technician WHERE Team = 'CWS';

/*
Prediction Result:
*/