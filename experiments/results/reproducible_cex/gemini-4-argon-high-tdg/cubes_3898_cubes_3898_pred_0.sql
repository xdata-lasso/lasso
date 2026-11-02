-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('Alice', 20, 'New York', 'F', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Mona', 25, 'Los Angeles', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zack', 45, 'Chicago', 'M', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('Zoe', 30, 'Boston', 'F', 'Teacher');
INSERT INTO PersonFriend (friend, name, year) VALUES ('Mona', 'Zack', 2025);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Zoe', 'Mona', 2015);
INSERT INTO PersonFriend (friend, name, year) VALUES ('Alice', 'Alice', 2005);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM personfriend AS LHS WHERE EXISTS(SELECT 1 FROM (SELECT name, age, city, gender, job, AVG(age) OVER () AS meanage FROM person) AS RHS WHERE (LHS.name = RHS.name))) ORDER BY friend DESC) LIMIT 1);

/*
Gold Result:
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT T2.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.friend WHERE T1.age < (SELECT AVG(age) FROM person);

/*
Prediction Result:
('Zack',)
('Alice',)
*/