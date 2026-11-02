-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty manager table to differentiate SELECT AVG(age) FROM manager (returns 1 row with NULL) vs window function SELECT DISTINCT AVG(age) OVER () FROM manager (returns 0 rows).
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Central Line', 'Beyer Peacock', '1890', '4-4-0', 'London', 'OBJ-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(age) OVER () AS avg_age_ FROM manager ORDER BY avg_age_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Age) FROM manager;

/*
Prediction Result:
(None,)
*/