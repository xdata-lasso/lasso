-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by wheels (ASC), tie-breaking by railway_id (ASC), and duplicate output rows (to kill DISTINCT / GROUP BY mutants).
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (10, 'Great Western', 'Swindon', '1923', '4-6-0', 'York', '1975-7000');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'LNER', 'Doncaster', '1938', '4-6-2', 'London', '1975-7001');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (5, 'LMS', 'Crewe', '1935', '4-6-0', 'Manchester', '1975-7002');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (8, 'Southern', 'Eastleigh', '1941', '0-6-0', 'York', '1975-7003');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (12, 'Midland', 'Derby', '1910', '4-6-0', 'York', '1975-7004');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT wheels, LOCATION FROM railway ORDER BY wheels, railway.railway_id NULLS LAST;

/*
Gold Result:
('0-6-0', 'York')
('4-6-0', 'Manchester')
('4-6-0', 'York')
('4-6-0', 'York')
('4-6-2', 'London')
*/

-- Prediction Query
SELECT Wheels, LOCATION FROM railway;

/*
Prediction Result:
('4-6-2', 'London')
('4-6-0', 'Manchester')
('0-6-0', 'York')
('4-6-0', 'York')
('4-6-0', 'York')
*/