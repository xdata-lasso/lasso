-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Alice', 30, 'NY', 'F', 'Dev');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Bob', 29, 'LA', 'M', 'QA');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Charlie', 31, 'SF', 'M', 'PM');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('David', 39, 'TX', 'M', 'HR');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Eve', 40, 'FL', 'F', 'Ops');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Frank', 41, 'WA', 'M', 'CEO');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('Grace', NULL, 'OR', 'F', 'Intern');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_30', 50, 'NY', 'F', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_29', 50, 'NY', 'M', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_31', 50, 'NY', 'M', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_39', 50, 'NY', 'M', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_40', 50, 'NY', 'F', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_41', 50, 'NY', 'M', 'None');
INSERT INTO "Person" ("name", "age", "city", "gender", "job") VALUES ('F_NULL', 50, 'NY', 'F', 'None');
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_30', 'Alice', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_29', 'Bob', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_31', 'Charlie', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_39', 'David', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_40', 'Eve', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_41', 'Frank', 2020);
INSERT INTO "PersonFriend" ("friend", "name", "year") VALUES ('F_NULL', 'Grace', 2020);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('F_29',)
('F_30',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('David',)
('Eve',)
('Frank',)
('Grace',)
*/