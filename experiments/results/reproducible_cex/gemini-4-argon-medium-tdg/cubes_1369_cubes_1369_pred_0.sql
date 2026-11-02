-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests ties for maximum age, ORDER BY name vs insertion order, DISTINCT on cross join, NULL ages, and PersonFriend joins.
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Zack', 40, 'Boston', 'M', 'Doctor');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 40, 'NYC', 'F', 'Engineer');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'LA', 'M', 'Artist');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', NULL, 'Chicago', 'M', 'Teacher');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Zack', 2018);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.name AS name_other, RHS.age AS age_other, RHS.city AS city_other, RHS.gender AS gender_other, RHS.job AS job_other FROM person AS LHS CROSS JOIN (SELECT name, MAX(age) OVER () AS age, city, gender, job FROM person) AS RHS) WHERE (age >= age_other) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT name FROM Person WHERE age = (SELECT MAX(age) FROM person);

/*
Prediction Result:
('Zack',)
('Alice',)
*/