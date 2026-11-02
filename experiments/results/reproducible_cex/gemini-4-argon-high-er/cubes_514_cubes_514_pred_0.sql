-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'B', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'A', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'C', 9);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 3);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (2, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT * FROM (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) WHERE (n >= 3)) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id HAVING COUNT(*) >= 3;

/*
Prediction Result:
('B',)
('A',)
*/