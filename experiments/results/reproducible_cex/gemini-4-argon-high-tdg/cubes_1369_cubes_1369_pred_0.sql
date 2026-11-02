-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zoe', 60, 'Austin', 'female', 'lawyer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 30, 'Austin', 'male', 'lawyer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 60, 'Denver', 'female', 'artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Dave', 40, 'Miami', 'male', 'chef');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Mike', 60, 'Miami', 'male', 'chef');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Dave', 2015);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zoe', 'Alice', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.name AS name_other, RHS.age AS age_other, RHS.city AS city_other, RHS.gender AS gender_other, RHS.job AS job_other FROM person AS LHS CROSS JOIN (SELECT name, MAX(age) OVER () AS age, city, gender, job FROM person) AS RHS) WHERE (age >= age_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Mike',)
('Zoe',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age = (SELECT MAX(age) FROM person);

/*
Prediction Result:
('Zoe',)
('Alice',)
('Mike',)
*/