-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (0, NULL, 1), (1, 'default2', 1), (2, 'default1', 1), (3, 'default1', 1);
INSERT INTO friend (student_id, friend_id) VALUES (1, 2), (3, 1), (0, 1), (3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('default1', 2)
('default2', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
(None, 1)
('default2', 1)
('default1', 2)
*/