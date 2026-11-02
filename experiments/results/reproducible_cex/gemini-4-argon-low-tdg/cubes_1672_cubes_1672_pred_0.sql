-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (1, 'Great Northern', 'Beyer Peacock', '1890', '4-4-0', 'York', 'OBJ1');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (2, 'Southern', 'Alco', '1910', '2-8-2', 'London', 'OBJ2');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (3, 'Eastern', NULL, '1920', '4-6-2', 'Leeds', 'OBJ3');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (4, 'Western', 'Baldwin', '1930', '0-6-0', 'Bristol', 'OBJ4');
INSERT INTO "railway" ("Railway_ID", "Railway", "Builder", "Built", "Wheels", "Location", "ObjectNumber") VALUES (5, 'Andaman Exp', 'Kerr Stuart', '1940', '2-6-0', 'Derby', 'OBJ5');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (101, 1, 'T1', 'Andaman Exp', 'Chennai', 'Jammu');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (102, 1, 'T2', 'Andaman Exp', 'Jammu', 'Chennai');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (103, 2, 'T3', 'Andaman Exp', 'Delhi', 'Mumbai');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (104, 3, 'T4', 'Andaman Exp', 'Kolkata', 'Goa');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (105, NULL, 'T5', 'Andaman Exp', 'Pune', 'Jaipur');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (106, 4, 'T6', 'Shatabdi Exp', 'Bhopal', 'Delhi');
INSERT INTO "train" ("Train_ID", "Railway_ID", "Train_Num", "Name", "From", "Arrival") VALUES (107, 4, 'Andaman Exp', 'Rajdhani Exp', 'Andaman Exp', 'Andaman Exp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "builder" FROM (SELECT "LHS"."train_id" AS "train_id", "LHS"."train_num" AS "train_num", "LHS"."name" AS "name", "LHS"."from" AS "from", "LHS"."arrival" AS "arrival", "LHS"."railway_id" AS "railway_id", "RHS"."railway" AS "railway", "RHS"."builder" AS "builder", "RHS"."built" AS "built", "RHS"."wheels" AS "wheels", "RHS"."location" AS "location", "RHS"."objectnumber" AS "objectnumber" FROM (SELECT * FROM "train" WHERE ("name" = 'Andaman Exp')) AS LHS LEFT JOIN railway AS RHS ON (LHS.railway_id = RHS.railway_id)) ORDER BY builder, "builder" NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('Alco',)
('Beyer Peacock',)
('Beyer Peacock',)
*/

-- Prediction Query
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID = T2.Railway_ID WHERE T2.Name = 'Andaman Exp';

/*
Prediction Result:
('Beyer Peacock',)
('Beyer Peacock',)
('Alco',)
(None,)
*/