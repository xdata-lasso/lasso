-- Schema DDL
CREATE TABLE "driver" ("Driver_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Party" TEXT, "Home_city" TEXT, "Age" INTEGER);

CREATE TABLE "school" ("School_ID" INTEGER PRIMARY KEY, "Grade" TEXT, "School" TEXT, "Location" TEXT, "Type" TEXT);

CREATE TABLE "school_bus" ("School_ID" INTEGER, "Driver_ID" INTEGER, "Years_Working" INTEGER, "If_full_time" INTEGER, PRIMARY KEY ("School_ID", "Driver_ID"), FOREIGN KEY ("Driver_ID") REFERENCES "driver" ("Driver_ID"), FOREIGN KEY ("School_ID") REFERENCES "school" ("School_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests behavior when the target table 'driver' is completely empty, while other tables are populated.
-- Catches mutants that replace COUNT(*) OVER () with standard aggregate COUNT(*) (which returns 0 instead of an empty set) or queries the wrong table.
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (1, 'K-12', 'Central High', 'New York', 'Public');
INSERT INTO "school" ("School_ID", "Grade", "School", "Location", "Type") VALUES (2, '9-12', 'Westside Prep', 'Boston', 'Private');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count___ FROM driver ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM driver;

/*
Prediction Result:
(0,)
*/