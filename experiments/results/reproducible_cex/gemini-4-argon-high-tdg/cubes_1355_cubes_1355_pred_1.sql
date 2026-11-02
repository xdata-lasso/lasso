-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Dan', 40, 'Boston', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 35, 'Seattle', 'M', 'Teacher');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 25, 'New York', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 30, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Eve', 22, 'Austin', 'F', 'Lawyer');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Dan', 'Charlie', 2019);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Dan', 'Alice', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Charlie', 'Bob', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Eve', 'Dan', 2022);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Dan', 2023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) WHERE ("friend" = 'Dan' AND "friend" <> 'Alice') ORDER BY name, "name" NULLS LAST, "age" NULLS LAST;

/*
Gold Result:
('Alice', 25)
('Charlie', 35)
*/

-- Prediction Query
SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Dan' INTERSECT SELECT T1.name, T1.age FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice';

/*
Prediction Result:
*/