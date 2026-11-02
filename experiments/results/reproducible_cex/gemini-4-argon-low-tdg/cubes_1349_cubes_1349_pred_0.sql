-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 20, 'NYC', 'F', 'Dev');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 20, 'LA', 'F', 'QA');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 35, 'SF', 'F', 'PM');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 30, 'NYC', 'M', 'Dev');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', 31, 'Boston', 'M', 'Sales');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Frank', 10, 'Chicago', 'O', 'Student');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, gender FROM (SELECT gender, AVG(age) AS meanage FROM person GROUP BY gender) ORDER BY avg_age_, gender NULLS LAST;

/*
Gold Result:
(10.0, 'O')
(25.0, 'F')
(30.5, 'M')
*/

-- Prediction Query
SELECT AVG(age), gender FROM Person GROUP BY gender;

/*
Prediction Result:
(25.0, 'F')
(30.5, 'M')
(10.0, 'O')
*/