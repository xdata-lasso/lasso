-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'NYC', 'F', 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Beth', 30, 'NYC', 'F', 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Cara', NULL, NULL, 'F', 'doc');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Dina', 40, 'LA', 'F', 'doc');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Evan', 25, 'NYC', 'M', 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Fred', 25, 'NYC', 'M', 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Greg', 35, 'SF', 'M', 'doc');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Hank', 20, 'LA', NULL, 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Ivan', 22, 'LA', NULL, 'eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Jack', 50, 'SF', NULL, 'doc');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Katy', 28, 'NYC', 'X', 'law');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Liam', 29, 'NYC', 'X', 'law');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Mona', 31, 'NYC', 'X', 'law');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Beth', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Cara', 'Alice', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Evan', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count___, gender FROM (SELECT gender, job, COUNT(*) AS n FROM person GROUP BY gender, job) WHERE (n < 40) ORDER BY count___, gender NULLS LAST;

/*
Gold Result:
(1, 'M')
(1, None)
(2, 'F')
(2, 'M')
(2, None)
(3, 'X')
*/

-- Prediction Query
SELECT COUNT(*), gender FROM Person WHERE age < 40 GROUP BY gender;

/*
Prediction Result:
(2, None)
(2, 'F')
(3, 'M')
(3, 'X')
*/