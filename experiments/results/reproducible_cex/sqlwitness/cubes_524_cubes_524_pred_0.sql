-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (11, 'default2', 9), (1, NULL, NULL), (9, 'default2', 1), (10, NULL, 0), (0, 'default2', 9), (2, NULL, 9), (3, 'default2', 0), (4, NULL, 10), (5, 'default1', 10), (6, NULL, 9), (7, 'default2', NULL), (8, 'default2', 11), (12, 'default2', 10), (13, NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM highschooler WHERE (grade = 10) ORDER BY name, highschooler.id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM Highschooler WHERE grade = 10;

/*
Prediction Result:
(None,)
('default1',)
('default2',)
(None,)
*/