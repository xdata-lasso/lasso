-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'NY', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 25, 'LA', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 40, 'NY', 'M', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Diana', 35, 'SF', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', 20, 'LA', 'F', 'Artist');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT age AS min_age_, job FROM (SELECT job, MIN(age) AS age FROM person GROUP BY job) ORDER BY min_age_, job NULLS LAST;

/*
Gold Result:
(20, 'Artist')
(25, 'Engineer')
(35, 'Doctor')
*/

-- Prediction Query
SELECT MIN(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(20, 'Artist')
(35, 'Doctor')
(25, 'Engineer')
*/