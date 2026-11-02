-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic matching, multiple 'Kyle' rows with duplicate and distinct grades (kills DISTINCT, LIMIT 1, and ORDER BY DESC mutants), and non-matching names.
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Kyle', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Kyle', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Kyle', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Alice', 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "grade" FROM "highschooler" WHERE ("name" = 'Kyle') ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(9,)
(9,)
(12,)
*/

-- Prediction Query
SELECT grade FROM Highschooler WHERE name = 'Kyle';

/*
Prediction Result:
(12,)
(9,)
(9,)
*/