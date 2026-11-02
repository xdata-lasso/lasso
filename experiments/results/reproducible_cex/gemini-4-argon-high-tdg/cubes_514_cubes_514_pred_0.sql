-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Dan', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Eli', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Fay', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (10, 'Zoe', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (20, 'Ada', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (30, 'Mia', 9);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (3, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (3, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (10, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (10, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (10, 3);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 3);
INSERT INTO Friend (student_id, friend_id) VALUES (20, 10);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 3);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 10);
INSERT INTO Friend (student_id, friend_id) VALUES (30, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT * FROM (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) WHERE (n >= 3)) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name;

/*
Gold Result:
('Ada',)
('Mia',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id HAVING COUNT(*) >= 3;

/*
Prediction Result:
('Zoe',)
('Ada',)
('Mia',)
*/