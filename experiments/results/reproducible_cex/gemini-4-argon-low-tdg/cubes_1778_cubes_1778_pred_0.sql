-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (10.0, 'Tech A', 'CLE', 1995.0, 45);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (30.0, 'Tech B', 'CWS', 2005.0, 35);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (20.0, 'Tech C', 'CWS', 2010.0, 28);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (5.0, 'Tech D', 'NYY', 1990.0, 50);
INSERT INTO "technician" ("technician_id", "Name", "Team", "Starting_Year", "Age") VALUES (1.0, 'Tech E', NULL, 2000.0, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "starting_year" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "technician" WHERE ("team" <> 'CLE' AND "team" = 'CWS')) ORDER BY technician_id) LIMIT 1);

/*
Gold Result:
(2010.0,)
*/

-- Prediction Query
SELECT Starting_Year FROM technician WHERE Team = 'CLE' INTERSECT SELECT Starting_Year FROM technician WHERE Team = 'CWS';

/*
Prediction Result:
*/