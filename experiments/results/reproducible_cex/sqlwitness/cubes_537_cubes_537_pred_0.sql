-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (0, 'default2', NULL), (1, NULL, 1), (2, 'default2', 0), (3, 'default2', 0), (4, 'default1', 0), (5, 'default1', NULL), (6, 'default1', NULL), (7, 'default1', 0), (8, NULL, NULL);
INSERT INTO likes (student_id, liked_id) VALUES (1, 4), (6, 5), (0, 8), (4, 4), (3, 7), (3, 5), (0, 7), (0, 4), (6, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM likes GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
(None, 1)
('default1', 1)
('default1', 2)
('default2', 2)
('default2', 3)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
('default2', 3)
(None, 1)
('default2', 2)
('default1', 1)
('default1', 2)
*/