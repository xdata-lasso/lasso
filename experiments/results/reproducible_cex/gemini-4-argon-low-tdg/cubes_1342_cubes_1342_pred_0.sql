-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'New York', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 30, 'Boston', 'M', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 31, 'Chicago', 'M', 'Teacher');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 39, 'Seattle', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', 40, 'Austin', 'F', 'Lawyer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Frank', 45, 'Denver', 'M', 'Chef');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Grace', NULL, 'Miami', 'F', 'Nurse');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zack', 50, 'LA', 'M', 'Actor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Aaron', 20, 'LA', 'M', 'Student');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Middle', 35, 'LA', 'F', 'Writer');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zack', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Aaron', 'Bob', 2019);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Middle', 'Charlie', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'David', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Eve', 2017);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Charlie', 'Frank', 2016);
INSERT INTO PersonFriend (friend, name, year) VALUES ('David', 'Grace', 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Zack',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
('Alice',)
*/