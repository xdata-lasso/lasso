-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in job (ORDER BY job NULLS LAST when avg_age_ is tied), NULL in age (AVG ignores NULLs), and NULL/case-sensitivity in gender.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M1', 40, 'NY', 'male', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M2', 40, 'NY', 'male', 'Zookeeper');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M3', 40, 'NY', 'male', 'Accountant');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M4', 20, 'NY', 'male', 'Baker');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M5', NULL, 'NY', 'male', 'Baker');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M6', NULL, 'NY', 'male', 'Unemployed');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F1', 25, 'NY', NULL, 'Baker');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('M7', 25, 'NY', 'Male', 'Baker');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_age_", "job" FROM (SELECT "gender", "job", AVG("age") AS "meanage" FROM "person" GROUP BY "gender", "job") WHERE ("gender" = 'male') ORDER BY avg_age_, "job" NULLS LAST;

/*
Gold Result:
(None, 'Unemployed')
(20.0, 'Baker')
(40.0, 'Accountant')
(40.0, 'Zookeeper')
(40.0, None)
*/

-- Prediction Query
SELECT AVG(age), job FROM Person WHERE gender = 'male' GROUP BY job;

/*
Prediction Result:
(40.0, None)
(40.0, 'Accountant')
(20.0, 'Baker')
(None, 'Unemployed')
(40.0, 'Zookeeper')
*/