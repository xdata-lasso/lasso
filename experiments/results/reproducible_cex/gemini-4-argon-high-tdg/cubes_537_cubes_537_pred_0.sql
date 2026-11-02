-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Alice', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Bob', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'Charlie', 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'David', 9);
INSERT INTO Friend (student_id, friend_id) VALUES (5, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 5);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 2);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 2);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 3);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 4);
INSERT INTO Likes (student_id, liked_id) VALUES (2, 3);
INSERT INTO Likes (student_id, liked_id) VALUES (3, 1);
INSERT INTO Likes (student_id, liked_id) VALUES (3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM likes GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 3)
('Bob', 2)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
('Alice', 3)
('Alice', 1)
('Bob', 2)
*/