-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'New York', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 30, 'Boston', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 40, 'New York', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 50, 'Chicago', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', 22, 'Seattle', 'F', 'Artist');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Alice', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Charlie', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, job FROM (SELECT gender, job, AVG(age) AS meanage FROM person GROUP BY gender, job) ORDER BY avg_age_, job NULLS LAST;

/*
Gold Result:
(22.0, 'Artist')
(27.5, 'Engineer')
(45.0, 'Engineer')
*/

-- Prediction Query
SELECT AVG(age), job FROM Person GROUP BY job;

/*
Prediction Result:
(22.0, 'Artist')
(36.25, 'Engineer')
*/