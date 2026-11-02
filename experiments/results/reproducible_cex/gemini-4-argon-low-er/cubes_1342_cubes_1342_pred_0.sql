-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 25, 'NYC', 'F', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 25, 'NYC', 'M', 'Dev');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('Bob', 'Alice', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
*/