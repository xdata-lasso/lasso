-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 45, 'Boston', 'F', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 28, 'Chicago', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 35, 'Boston', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Diana', 50, 'Seattle', 'F', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Evan', 40, 'Austin', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Fiona', 22, 'Denver', 'F', 'Engineer');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Diana', 'Alice', 2015);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Charlie', 'Alice', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age AS min_age_, job FROM (SELECT job, MIN(age) AS age FROM person GROUP BY job) ORDER BY min_age_, job NULLS LAST;

/*
Gold Result:
(22, 'Engineer')
(28, 'Doctor')
(40, 'Artist')
*/

-- Prediction Query
SELECT MIN(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(40, 'Artist')
(28, 'Doctor')
(22, 'Engineer')
*/