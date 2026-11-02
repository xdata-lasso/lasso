-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Wrong Railway 1', 'Wrong_Builder_ID1', '1901', '4-4-0', 'London', 'OBJ-001');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Wrong Railway 2', 'Wrong_Builder_ID2', '1902', '4-6-0', 'Manchester', 'OBJ-002');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (3, 'Andaman Exp', 'Wrong_Builder_ID3', '1903', '2-8-0', 'Leeds', 'OBJ-003');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (10, 'Southern Railway', 'Vulcan Foundry', '1950', '4-6-2', 'Chennai', 'OBJ-010');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (20, 'Northern Railway', 'Beyer, Peacock', '1935', '2-6-4', 'Delhi', 'OBJ-020');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (30, 'Central Railway', 'North British', '1942', '0-6-0', 'Mumbai', 'OBJ-030');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'Alice Smith', 'India', '2010', 45, 3);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Bob Jones', 'UK', '2015', 38, 2);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (20, 1, '2018');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (20, 2, '2020');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2012');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 10, 'T-16031', 'Andaman Exp', 'Chennai', 'Jammu');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 20, 'T-16032', 'Andaman Exp', 'Jammu', 'Chennai');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (3, 30, 'T-16033', 'Andaman Exp', 'Nagpur', 'Bhopal');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (4, 1, 'T-99901', 'Andaman Express', 'Chennai', 'Jammu');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (5, 2, 'T-99902', 'andaman exp', 'Delhi', 'Agra');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (6, 3, 'T-99903', 'Grand Trunk Exp', 'Andaman Exp', 'Andaman Exp');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (7, 1, 'T-99904', NULL, 'Kolkata', 'Patna');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "builder" FROM (SELECT "LHS"."train_id" AS "train_id", "LHS"."train_num" AS "train_num", "LHS"."name" AS "name", "LHS"."from" AS "from", "LHS"."arrival" AS "arrival", "LHS"."railway_id" AS "railway_id", "RHS"."railway" AS "railway", "RHS"."builder" AS "builder", "RHS"."built" AS "built", "RHS"."wheels" AS "wheels", "RHS"."location" AS "location", "RHS"."objectnumber" AS "objectnumber" FROM (SELECT * FROM "train" WHERE ("name" = 'Andaman Exp')) AS LHS LEFT JOIN railway AS RHS ON (LHS.railway_id = RHS.railway_id)) ORDER BY builder, "builder" NULLS LAST;

/*
Gold Result:
('Beyer, Peacock',)
('North British',)
('Vulcan Foundry',)
*/

-- Prediction Query
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID = T2.Railway_ID WHERE T2.Name = 'Andaman Exp';

/*
Prediction Result:
('Vulcan Foundry',)
('Beyer, Peacock',)
('North British',)
*/