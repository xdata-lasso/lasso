-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests:
-- 1. Empty manager table: Window function AVG(age) OVER () returns 0 rows, whereas aggregate SELECT AVG(age) FROM manager without GROUP BY returns 1 row (NULL).
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Northern', 'Lima', '1940', '4-8-4', 'USA', '301');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (1, 1, 'T1', 'Express', 'NY', 'LA');
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