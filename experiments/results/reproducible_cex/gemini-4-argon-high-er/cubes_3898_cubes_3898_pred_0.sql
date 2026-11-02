-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('A', 20, 'NY', 'M', 'Dev');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('A', 'A', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM personfriend AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT name, age, city, gender, job, AVG(age) OVER () AS meanage FROM person) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend DESC) LIMIT 1);

/*
Gold Result:
('A',)
*/

-- Prediction Query
SELECT DISTINCT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.age < (SELECT AVG(age) FROM person);

/*
Prediction Result:
*/