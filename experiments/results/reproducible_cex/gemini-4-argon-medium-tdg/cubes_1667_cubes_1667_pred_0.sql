-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard anti-join, ordering (descending insert order to catch missing ORDER BY), duplicate ObjectNumbers (to catch DISTINCT mutants), and wrong column projection.
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Rail_One', 'B1', '1990', '4-4-0', 'Loc1', 'OBJ_Z');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Rail_Two', 'B2', '1991', '4-6-2', 'Loc2', 'OBJ_A');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'Rail_Three', 'B3', '1992', '2-8-0', 'Loc3', 'OBJ_M');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (4, 'Rail_Four', 'B4', '1993', '0-6-0', 'Loc4', 'OBJ_A');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (10, 1, 'T100', 'Express', 'CityA', '10:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (20, 1, 'T101', 'Local', 'CityB', '12:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT objectnumber FROM (SELECT * FROM railway AS LHS WHERE NOT EXISTS(SELECT 1 FROM train AS RHS WHERE (LHS.railway_id = RHS.railway_id))) ORDER BY objectnumber;

/*
Gold Result:
('OBJ_A',)
('OBJ_A',)
('OBJ_M',)
*/

-- Prediction Query
SELECT ObjectNumber FROM railway WHERE NOT Railway_ID IN (SELECT Railway_ID FROM train);

/*
Prediction Result:
('OBJ_A',)
('OBJ_M',)
('OBJ_A',)
*/