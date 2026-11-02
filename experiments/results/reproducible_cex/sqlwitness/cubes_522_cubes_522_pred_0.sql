-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (0, 'default1', NULL), (1, NULL, NULL), (2, NULL, 1), (3, 'default2', 0), (4, 'default2', NULL), (5, NULL, NULL), (6, 'default1', 1), (7, 'default1', 1), (8, 'default2', 1), (9, 'default2', 0), (10, 'default2', 1), (11, 'default2', NULL), (12, NULL, 0), (13, 'default2', 0), (14, NULL, 0), (15, NULL, 1), (16, NULL, NULL), (17, NULL, 1), (18, 'default1', 1), (19, 'default2', NULL), (20, 'default1', 0), (21, 'default1', 0), (22, NULL, NULL), (23, 'default1', 1);
INSERT INTO likes (student_id, liked_id) VALUES (19, 15), (20, 11), (21, 1), (21, 10), (23, 7), (16, 10), (0, 0), (2, 10), (14, 20), (5, 4), (8, 16), (23, 15), (1, 19), (11, 11), (21, 7);
INSERT INTO friend (student_id, friend_id) VALUES (2, 3), (1, 20), (0, 17);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, LHS.student_id AS student_id, LHS.friend_id AS friend_id, RHS.student_id AS student_id_other FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.student_id AS student_id, RHS.friend_id AS friend_id FROM highschooler AS LHS CROSS JOIN friend AS RHS) AS LHS INNER JOIN likes AS RHS ON (LHS.id = RHS.liked_id)) ORDER BY name;

/*
Gold Result:
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id INTERSECT SELECT T2.name FROM Likes AS T1 JOIN Highschooler AS T2 ON T1.liked_id = T2.id;

/*
Prediction Result:
(None,)
('default1',)
*/