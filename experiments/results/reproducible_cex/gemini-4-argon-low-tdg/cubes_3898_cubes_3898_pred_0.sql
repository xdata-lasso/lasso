-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 20, 'NY', 'F', 'Dev');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Bob', 40, 'LA', 'M', 'QA');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Charlie', 35, 'SF', 'M', 'PM');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zack', 25, 'NY', 'M', 'HR');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zack', 'Alice', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Charlie', 'Bob', 2015);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM personfriend AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT name, age, city, gender, job, AVG(age) OVER () AS meanage FROM person) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend DESC) LIMIT 1);

/*
Gold Result:
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.age < (SELECT AVG(age) FROM person);

/*
Prediction Result:
('Alice',)
*/