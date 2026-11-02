-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'boston', 'F', 'engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 20, 'new york city', 'M', 'doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 40, 'chicago', 'M', 'artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Diana', 35, 'new york city', 'F', 'lawyer');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Charlie', 2010);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Diana', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name_other" AS "name" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."name" AS "name_other", "RHS"."year" AS "year" FROM (SELECT * FROM "person" WHERE ("city" = 'new york city')) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.friend)) ORDER BY name;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.city = 'new york city';

/*
Prediction Result:
('Charlie',)
('Alice',)
*/