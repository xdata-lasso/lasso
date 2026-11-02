-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY (gender, job), floating point AVG, and multi-column ORDER BY
-- Refutes mutants that group only by job, group only by gender, or use integer division for AVG
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 20, 'NY', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 21, 'LA', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 50, 'NY', 'M', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 30, 'Chicago', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 30, 'Boston', 'F', 'Artist');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(20.5, 'Engineer')
(30.0, 'Artist')
(30.0, 'Doctor')
(50.0, 'Engineer')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(30.0, 'Artist')
(30.0, 'Doctor')
(30.333333333333332, 'Engineer')
*/