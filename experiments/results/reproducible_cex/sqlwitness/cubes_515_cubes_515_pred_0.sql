-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (1, 'Kyle', NULL), (0, 'Kyle', 1), (2, 'default2', 0), (3, 'default1', NULL), (4, NULL, NULL), (5, 'default2', NULL), (6, NULL, 0), (7, 'default1', 0), (8, NULL, 0), (9, 'default1', NULL), (10, 'default2', 0), (11, 'default1', 1), (12, NULL, 1), (13, NULL, 1), (14, 'default1', NULL), (15, 'default1', 1), (16, 'Kyle', 1), (17, 'default1', 1), (18, 'Kyle', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "id" FROM "highschooler" WHERE ("name" = 'Kyle') ORDER BY id;

/*
Gold Result:
(0,)
(1,)
(16,)
(18,)
*/

-- Prediction Query
SELECT ID FROM Highschooler WHERE name = 'Kyle';

/*
Prediction Result:
(0,)
(1,)
(16,)
(18,)
*/