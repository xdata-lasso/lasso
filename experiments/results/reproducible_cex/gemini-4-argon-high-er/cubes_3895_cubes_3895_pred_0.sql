-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 20, 'NY', 'F', 'Dev');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 25, 'LA', 'M', 'Eng');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 30, 'SF', 'M', 'Doc');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Bob', 2010);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Charlie', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name", "age", "job" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "LHS"."friend" AS "friend", "LHS"."year" AS "year", "RHS"."maxyear" AS "maxyear" FROM (SELECT "LHS"."name" AS "name", "LHS"."age" AS "age", "LHS"."city" AS "city", "LHS"."gender" AS "gender", "LHS"."job" AS "job", "RHS"."friend" AS "friend", "RHS"."year" AS "year" FROM "person" AS "LHS" INNER JOIN "personfriend" AS "RHS" ON ("LHS"."name" = "RHS"."name")) AS "LHS" INNER JOIN (SELECT "name", "year", MAX("year") AS "maxyear" FROM "personfriend" WHERE ("friend" = 'Alice') GROUP BY name, YEAR) AS RHS ON (LHS.name = RHS.name AND LHS.year = RHS.year)) ORDER BY name, "name" NULLS LAST, "age" NULLS LAST, "job" NULLS LAST;

/*
Gold Result:
('Bob', 25, 'Eng')
('Charlie', 30, 'Doc')
*/

-- Prediction Query
SELECT T1.name, T1.age, T1.job FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend = 'Alice' AND T2.year = (SELECT MAX(YEAR) FROM PersonFriend WHERE friend = 'Alice');

/*
Prediction Result:
('Charlie', 30, 'Doc')
*/