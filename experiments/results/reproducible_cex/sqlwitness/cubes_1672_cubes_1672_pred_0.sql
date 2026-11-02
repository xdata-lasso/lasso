-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO railway (railway_id, railway, builder, built, wheels, location, objectnumber) VALUES (1, 'default1', 'default2', 'Andaman Exp', 'Andaman Exp', NULL, 'Andaman Exp'), (0, 'default1', 'Andaman Exp', 'default2', NULL, 'default1', 'Andaman Exp'), (2, 'Andaman Exp', 'default1', 'default2', 'Andaman Exp', 'default2', NULL), (3, 'default2', 'Andaman Exp', 'Andaman Exp', 'Andaman Exp', 'default2', 'Andaman Exp');
INSERT INTO train (train_id, railway_id, train_num, name, "from", arrival) VALUES (1, 2, 'default1', NULL, 'Andaman Exp', 'default2'), (0, 2, NULL, 'Andaman Exp', NULL, 'default2'), (2, NULL, 'default1', 'Andaman Exp', 'default2', 'default2'), (3, 0, NULL, NULL, NULL, 'Andaman Exp');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "builder" FROM (SELECT "LHS"."train_id" AS "train_id", "LHS"."train_num" AS "train_num", "LHS"."name" AS "name", "LHS"."from" AS "from", "LHS"."arrival" AS "arrival", "LHS"."railway_id" AS "railway_id", "RHS"."railway" AS "railway", "RHS"."builder" AS "builder", "RHS"."built" AS "built", "RHS"."wheels" AS "wheels", "RHS"."location" AS "location", "RHS"."objectnumber" AS "objectnumber" FROM (SELECT * FROM "train" WHERE ("name" = 'Andaman Exp')) AS LHS LEFT JOIN railway AS RHS ON (LHS.railway_id = RHS.railway_id)) ORDER BY builder, "builder" NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
*/

-- Prediction Query
SELECT T1.Builder FROM railway AS T1 JOIN train AS T2 ON T1.Railway_ID = T2.Railway_ID WHERE T2.Name = 'Andaman Exp';

/*
Prediction Result:
('default1',)
*/