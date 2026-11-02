-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 40, 'NYC', 'male', 'doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 20, 'LA', 'male', 'engineer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanage" AS "avg_age_", "job" FROM (SELECT "gender", "job", AVG("age") AS "meanage" FROM "person" GROUP BY "gender", "job") WHERE ("gender" = 'male') ORDER BY avg_age_, "job" NULLS LAST;

/*
Gold Result:
(20.0, 'engineer')
(40.0, 'doctor')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person WHERE gender = 'male' GROUP BY job;

/*
Prediction Result:
(40.0, 'doctor')
(20.0, 'engineer')
*/