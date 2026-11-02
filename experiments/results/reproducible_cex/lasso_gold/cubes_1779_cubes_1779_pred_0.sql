-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1008.5, 'Javier Johnson', 'rate', 1009.5, 1010);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1011.5, 'Lance Hoffman', 'discover', 1010.5, 1011);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT team, starting_year FROM technician ORDER BY team, technician.technician_id NULLS LAST;

/*
Gold Result:
('discover', 1010.5)
('rate', 1009.5)
*/

-- Prediction Query
SELECT Team, Starting_Year FROM technician;

/*
Prediction Result:
('rate', 1009.5)
('discover', 1010.5)
*/