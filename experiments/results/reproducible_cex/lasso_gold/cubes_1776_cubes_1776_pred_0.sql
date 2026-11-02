-- Schema DDL
CREATE TABLE "repair" ("repair_ID" INTEGER PRIMARY KEY, "name" TEXT, "Launch_Date" TEXT, "Notes" TEXT);

CREATE TABLE "machine" ("Machine_ID" INTEGER PRIMARY KEY, "Making_Year" INTEGER, "Class" TEXT, "Team" TEXT, "Machine_series" TEXT, "value_points" REAL, "quality_rank" INTEGER);

CREATE TABLE "technician" ("technician_id" REAL PRIMARY KEY, "Name" TEXT, "Team" TEXT, "Starting_Year" REAL, "Age" INTEGER);

CREATE TABLE "repair_assignment" ("technician_id" INTEGER, "repair_ID" INTEGER, "Machine_ID" INTEGER, PRIMARY KEY ("technician_id", "repair_ID", "Machine_ID"), FOREIGN KEY ("Machine_ID") REFERENCES "machine" ("Machine_ID"), FOREIGN KEY ("repair_ID") REFERENCES "repair" ("repair_ID"), FOREIGN KEY ("technician_id") REFERENCES "technician" ("technician_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1033.5, 'Maria Lynch', 'Congress', 1034.5, 36);
INSERT INTO "technician" ("technician_id", "name", "team", "starting_year", "age") VALUES (1035.5, 'Margaret Hawkins DDS', 'expect', 1035.5, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM technician WHERE (age >= 36 AND age <= 37) ORDER BY name, technician.technician_id NULLS LAST;

/*
Gold Result:
('Margaret Hawkins DDS',)
('Maria Lynch',)
*/

-- Prediction Query
SELECT Name FROM technician WHERE Age = 36 OR Age = 37;

/*
Prediction Result:
('Maria Lynch',)
('Margaret Hawkins DDS',)
*/