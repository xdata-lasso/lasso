-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1001, 'purpose', 'brother', 'ago', 'site', '18196 Anthony Forge
New Carolyn, OH 26563', 'sense');
INSERT INTO "railway" ("railway_id", "railway", "builder", "built", "wheels", "location", "objectnumber") VALUES (1004, 'purpose', 'brother', 'ago', 'site', '18196 Anthony Forge
New Carolyn, OH 26563', 'sense');
INSERT INTO "train" ("train_id", "railway_id", "train_num", "name", "from", "arrival") VALUES (1002, 1001, 'rate', 'Andaman Exp', 'science', 'offer');
INSERT INTO "train" ("train_id", "railway_id", "train_num", "name", "from", "arrival") VALUES (1005, NULL, 'rate', 'Andaman Exp', 'science', 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "builder" FROM (SELECT "LHS"."train_id" AS "train_id", "LHS"."train_num" AS "train_num", "LHS"."name" AS "name", "LHS"."from" AS "from", "LHS"."arrival" AS "arrival", "LHS"."railway_id" AS "railway_id", "RHS"."railway" AS "railway", "RHS"."builder" AS "builder", "RHS"."built" AS "built", "RHS"."wheels" AS "wheels", "RHS"."location" AS "location", "RHS"."objectnumber" AS "objectnumber" FROM (SELECT * FROM "train" WHERE ("name" = 'Andaman Exp')) AS LHS LEFT JOIN railway AS RHS ON (LHS.railway_id = RHS.railway_id)) ORDER BY builder, "builder" NULLS LAST;

/*
Gold Result:
(None,)
('brother',)
*/

-- Prediction Query
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID = T2.Railway_ID WHERE T2.Name = 'Andaman Exp';

/*
Prediction Result:
('brother',)
*/