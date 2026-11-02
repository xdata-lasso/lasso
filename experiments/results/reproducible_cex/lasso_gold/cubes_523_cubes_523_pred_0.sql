-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1022, 'Kyle', 1024);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1024, 'Kyle', 1023);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "grade" FROM "highschooler" WHERE ("name" = 'Kyle') ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(1023,)
(1024,)
*/

-- Prediction Query
SELECT grade FROM Highschooler WHERE name = 'Kyle';

/*
Prediction Result:
(1024,)
(1023,)
*/