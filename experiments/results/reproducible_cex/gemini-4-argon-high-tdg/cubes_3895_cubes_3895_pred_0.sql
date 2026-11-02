-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zoe', 22, 'Boston', 'F', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 30, 'New York', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 45, 'Chicago', 'M', 'Chef');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 28, 'Seattle', 'M', 'Teacher');
INSERT INTO Person (name, age, city, gender, job) VALUES ('David', 35, 'Austin', 'M', 'Lawyer');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Zoe', 2015);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Charlie', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Bob', 'Charlie', 2019);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age", "job" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."friend" AS "friend", "LHS"."year" AS "year", "RHS"."maxyear" AS "maxyear" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) AS "LHS" INNER JOIN (SELECT "name", "year", MAX("year") AS "maxyear" FROM "personfriend" WHERE ("friend" = 'Alice') GROUP BY name, YEAR) AS RHS ON (LHS.name = RHS.name AND LHS.year = RHS.year)) ORDER BY name, "name" NULLS LAST, "age" NULLS LAST, "job" NULLS LAST;

/*
Gold Result:
('Bob', 45, 'Chef')
('Zoe', 22, 'Artist')
*/

-- Prediction Query
SELECT T1.name, T1.age, T1.job FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice' AND T2.year = (SELECT MAX(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('Bob', 45, 'Chef')
*/