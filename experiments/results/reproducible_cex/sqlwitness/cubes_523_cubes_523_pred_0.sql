-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO highschooler (id, name, grade) VALUES (1, 'Kyle', 1), (0, 'default1', 0), (2, 'default2', NULL), (3, 'default2', 0), (4, 'default1', NULL), (5, NULL, NULL), (6, 'Kyle', NULL), (7, 'Kyle', 1), (8, 'Kyle', 0), (9, 'default1', 0), (10, NULL, 0), (11, NULL, 0), (12, 'Kyle', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "grade" FROM "highschooler" WHERE ("name" = 'Kyle') ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
(0,)
(1,)
(1,)
*/

-- Prediction Query
SELECT grade FROM Highschooler WHERE name = 'Kyle';

/*
Prediction Result:
(1,)
(None,)
(1,)
(0,)
(None,)
*/