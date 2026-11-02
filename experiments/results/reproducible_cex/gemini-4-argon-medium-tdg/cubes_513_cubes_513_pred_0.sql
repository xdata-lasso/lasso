-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Highschooler (ID, name, grade) VALUES (10, 'Zack', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (20, 'Zack', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (30, 'Aaron', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (40, 'Beta', 11);
INSERT INTO Friend (student_id, friend_id) VALUES (10, 30);
INSERT INTO Friend (student_id, friend_id) VALUES (10, 40);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 30);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 40);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 10);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id))) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Aaron',)
('Zack',)
('Zack',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.grade > 5 GROUP BY T1.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zack',)
('Zack',)
('Aaron',)
*/