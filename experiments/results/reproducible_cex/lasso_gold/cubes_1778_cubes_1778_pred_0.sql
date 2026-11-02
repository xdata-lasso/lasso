-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1001.5, 'Allison Hill', 'CWS', 1005.5, 1009);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1002.5, 'Noah Rhodes', 'CWS', 1014.5, 1020.0);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1003.5, 'Angie Henderson', 'CWS', 1023.5, 1031.0);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1004.5, 'Daniel Wagner', 'CWS', 1032.5, 1042.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "starting_year" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "technician" WHERE ("team" <> 'CLE' AND "team" = 'CWS')) ORDER BY technician_id) LIMIT 1);

/*
Gold Result:
(1005.5,)
*/

-- Prediction Query
SELECT Starting_Year FROM technician WHERE Team = 'CLE' INTERSECT SELECT Starting_Year FROM technician WHERE Team = 'CWS';

/*
Prediction Result:
*/