-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests SELECT DISTINCT, GROUP BY (gender, job), NULL handling in COUNT(*) vs COUNT(col), and ORDER BY (count___, gender NULLS LAST).
-- Specifically catches: missing DISTINCT, GROUP BY gender only, COUNT(job)/COUNT(gender) instead of COUNT(*), and wrong sort order or NULLS FIRST.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'NYC', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 30, 'LA', 'F', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Chicago', 'M', 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 40, 'Chicago', 'M', 'Teacher');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 22, 'Boston', 'F', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 28, 'Boston', 'F', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Grace', 33, 'Seattle', NULL, 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Heidi', 29, 'Austin', 'M', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, gender FROM (SELECT gender, job, COUNT(*) AS n FROM person GROUP BY gender, job) WHERE (n < 40) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, 'F')
(1, 'M')
(1, None)
(2, 'F')
(2, 'M')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM Person WHERE age < 40 GROUP BY gender;

/*
Prediction Result:
(1, None)
(4, 'F')
(2, 'M')
*/