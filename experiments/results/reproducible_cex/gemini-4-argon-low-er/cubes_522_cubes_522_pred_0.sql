-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Bob', 10);
INSERT INTO Friend (student_id, friend_id) VALUES (1, 2);
INSERT INTO Likes (student_id, liked_id) VALUES (1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, LHS.student_id AS student_id, LHS.friend_id AS friend_id, RHS.student_id AS student_id_other FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.student_id AS student_id, RHS.friend_id AS friend_id FROM highschooler AS LHS CROSS JOIN friend AS RHS) AS LHS INNER JOIN likes AS RHS ON (LHS.id = RHS.liked_id)) ORDER BY name;

/*
Gold Result:
('Bob',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id INTERSECT SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.liked_id = T2.id;

/*
Prediction Result:
*/