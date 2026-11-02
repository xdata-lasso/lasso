-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests boundary conditions for count (0, 1, 2, 3), ordering by name vs ID/grade, and Friend vs Likes table confusion.
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Zack', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Bob', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'Charlie', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'David', 10);
-- Zack (ID 1) has exactly 2 friends (Boundary n = 2)
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 3);
-- Alice (ID 2) has 3 friends (Boundary n > 2)
INSERT INTO Friend (student_id, friend_id) VALUES (2, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 3);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 4);
-- Bob (ID 3) has 1 friend (Boundary n = 1, should be excluded)
INSERT INTO Friend (student_id, friend_id) VALUES (3, 1);
-- Charlie (ID 4) has 0 friends, but has 2 Likes (Tests table confusion between Friend and Likes)
INSERT INTO Likes (student_id, liked_id) VALUES (4, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT id, name, grade, n, id AS student_id FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id))) WHERE (n >= 2) ORDER BY name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id WHERE T2.grade > 5 GROUP BY T1.student_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zack',)
('Alice',)
*/