-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'Boston', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Betty', 40, 'Boston', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 20, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 20, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 21, 'Seattle', 'M', 'Lawyer');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Betty', 'Alice', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Betty', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT meanage AS avg_age_, gender FROM (SELECT gender, AVG(age) AS meanage FROM person GROUP BY gender) ORDER BY avg_age_, gender NULLS LAST;

/*
Gold Result:
(20.333333333333332, 'M')
(35.0, 'F')
*/

-- Prediction Query
SELECT AVG(age), gender FROM Person GROUP BY gender;

/*
Prediction Result:
(35.0, 'F')
(20.333333333333332, 'M')
*/