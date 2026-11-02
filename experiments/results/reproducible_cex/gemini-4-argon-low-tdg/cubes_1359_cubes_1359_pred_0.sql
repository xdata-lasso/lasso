-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 30, 'Boston', 'male', 'B_Job');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Grace', 30, 'Austin', 'male', 'A_Job');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Hank', 30, 'Seattle', 'male', NULL);
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Ian', 20, 'Miami', 'male', 'Z_Job');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Jack', 40, 'Denver', 'male', 'C_Job');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_age_", "job" FROM (SELECT "gender", "job", AVG("age") AS "meanage" FROM "person" GROUP BY "gender", "job") WHERE ("gender" = 'male') ORDER BY avg_age_, "job" NULLS LAST;

/*
Gold Result:
(20.0, 'Z_Job')
(30.0, 'A_Job')
(30.0, 'B_Job')
(30.0, None)
(40.0, 'C_Job')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person WHERE gender = 'male' GROUP BY job;

/*
Prediction Result:
(30.0, None)
(30.0, 'A_Job')
(30.0, 'B_Job')
(40.0, 'C_Job')
(20.0, 'Z_Job')
*/