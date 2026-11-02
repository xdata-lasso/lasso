-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Northern', 'Zeta Works', '1905', '4-6-2', 'York', 'OBJ-1');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'Southern Line', 'Alpha Corp', '1910', '2-8-0', 'London', 'OBJ-2');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (3, 'Eastern Line', 'Beta Ltd', '1920', '0-6-0', 'Leeds', 'OBJ-3');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (101, 1, 'T100', 'Andaman Exp', 'Chennai', 'Jammu');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (102, 1, 'T101', 'Andaman Exp', 'Delhi', 'Mumbai');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (103, 2, 'T102', 'Andaman Exp', 'Kolkata', 'Pune');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (104, 3, 'T103', 'Other Exp', 'Chennai', 'Jammu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "builder" FROM (SELECT "LHS"."train_id" AS "train_id", "LHS"."train_num" AS "train_num", "LHS"."name" AS "name", "LHS"."from" AS "from", "LHS"."arrival" AS "arrival", "LHS"."railway_id" AS "railway_id", "RHS"."railway" AS "railway", "RHS"."builder" AS "builder", "RHS"."built" AS "built", "RHS"."wheels" AS "wheels", "RHS"."location" AS "location", "RHS"."objectnumber" AS "objectnumber" FROM (SELECT * FROM "train" WHERE ("name" = 'Andaman Exp')) AS LHS LEFT JOIN railway AS RHS ON (LHS.railway_id = RHS.railway_id)) ORDER BY builder, "builder" NULLS LAST;

/*
Gold Result:
('Alpha Corp',)
('Zeta Works',)
('Zeta Works',)
*/

-- Prediction Query
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID = T2.Railway_ID WHERE T2.Name = 'Andaman Exp';

/*
Prediction Result:
('Zeta Works',)
('Zeta Works',)
('Alpha Corp',)
*/