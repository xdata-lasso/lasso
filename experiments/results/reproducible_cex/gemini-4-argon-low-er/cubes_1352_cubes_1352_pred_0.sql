-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'NY', 'F', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 20, 'LA', 'M', 'Engineer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age AS min_age_, job FROM (SELECT job, MIN(age) AS age FROM person GROUP BY job) ORDER BY min_age_, job NULLS LAST;

/*
Gold Result:
(20, 'Engineer')
(30, 'Doctor')
*/

-- Prediction Query
SELECT MIN(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(30, 'Doctor')
(20, 'Engineer')
*/