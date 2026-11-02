-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (3, 'default2', NULL), (1, 'default2', 2), (4, 'default1', 2), (2, 'default2', 1), (0, 'default2', 1), (5, NULL, NULL), (6, 'default2', NULL), (7, 'default2', 3), (8, 'default2', NULL), (9, NULL, 3), (10, 'default2', 0), (11, 'default1', 0), (12, 'default2', 4), (13, NULL, 4), (14, 'default2', 2), (15, 'default2', 4), (16, NULL, 2), (17, NULL, 2), (18, NULL, 0), (19, NULL, 3), (20, NULL, 4), (21, 'default1', 1), (22, NULL, 4), (23, 'default2', 3), (24, 'default2', 0), (25, 'default1', NULL), (26, 'default1', 4), (27, NULL, NULL), (28, 'default1', 3), (29, 'default1', 4), (30, 'default2', 4), (31, NULL, NULL), (32, 'default2', 3), (33, 'default2', NULL), (34, 'default1', 1), (35, NULL, 3), (36, 'default2', 1), (37, NULL, 4), (38, NULL, 2), (39, 'default2', 3), (40, 'default2', 2), (41, NULL, 1), (42, 'default1', 1), (43, 'default2', 4), (44, NULL, 4);
INSERT INTO friend (student_id, friend_id) VALUES (13, 37), (19, 34), (1, 35), (23, 12), (1, 40), (42, 38), (23, 11), (5, 21), (44, 2), (22, 14), (20, 37), (39, 29), (11, 39), (43, 17), (9, 12), (36, 36), (13, 7), (19, 44), (19, 38), (9, 14), (34, 36), (44, 32), (11, 31), (5, 34), (3, 11), (43, 6), (1, 41), (28, 24), (39, 5), (32, 38), (14, 12), (33, 20), (41, 12), (27, 25), (17, 37), (43, 2), (23, 32), (4, 25), (35, 16), (12, 17), (30, 16), (5, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT * FROM (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) WHERE (n >= 3)) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name;

/*
Gold Result:
(None,)
(None,)
('default2',)
('default2',)
('default2',)
*/

-- Prediction Query
SELECT T2.name FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id HAVING COUNT(*) >= 3;

/*
Prediction Result:
('default2',)
(None,)
(None,)
('default2',)
('default2',)
*/