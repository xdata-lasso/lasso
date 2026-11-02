-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Kyle', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Kyle', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Kyle', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Kyle', NULL);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (5, 'kyle', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (6, 'Kyle ', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (7, 'Kylee', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (8, 'Alice', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (9, NULL, 11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "grade" FROM "highschooler" WHERE ("name" = 'Kyle') ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(None,)
(10,)
(12,)
(12,)
*/

-- Prediction Query
SELECT grade FROM Highschooler WHERE name = 'Kyle';

/*
Prediction Result:
(12,)
(10,)
(12,)
(None,)
*/