-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'NYC', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'NYC', 'M', 'Engineer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(20.0, 'Engineer')
(30.0, 'Engineer')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(25.0, 'Engineer')
*/