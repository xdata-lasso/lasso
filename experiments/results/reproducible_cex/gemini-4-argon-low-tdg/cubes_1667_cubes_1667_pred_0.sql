-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard anti-join, ordering, duplicate ObjectNumber values (DISTINCT vs ALL), and joining on the wrong table (e.g., railway_manage instead of train).
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Western', 'Swindon', '1920', '4-6-0', 'London', 'OBJ-C');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'London Midland', 'Crewe', '1930', '4-6-2', 'Manchester', 'OBJ-A');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (3, 'Southern', 'Eastleigh', '1940', '4-6-2', 'Southampton', 'OBJ-A');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (4, 'Eastern', 'Doncaster', '1950', '2-8-0', 'York', 'OBJ-B');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (10, 4, 'T100', 'Flying Scotsman', 'London', 'Edinburgh');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (11, 4, 'T101', 'Mallard', 'York', 'London');
INSERT INTO "manager" ("Manager_ID", "Name", "Country", "Working_year_starts", "Age", "Level") VALUES (100, 'John Doe', 'UK', '2000', 45, 5);
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (1, 100, '2010');
INSERT INTO "railway_manage" ("Railway_ID", "Manager_ID", "From_Year") VALUES (4, 100, '2012');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT objectnumber FROM (SELECT * FROM railway AS LHS WHERE NOT EXISTS(SELECT 1 FROM train AS RHS WHERE (LHS.railway_id = RHS.railway_id))) ORDER BY objectnumber;

/*
Gold Result:
('OBJ-A',)
('OBJ-A',)
('OBJ-C',)
*/

-- Prediction Query
SELECT ObjectNumber FROM railway WHERE NOT Railway_ID IN (SELECT Railway_ID FROM train);

/*
Prediction Result:
('OBJ-C',)
('OBJ-A',)
('OBJ-A',)
*/