-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1006, 'Angie Henderson', 1008);
INSERT INTO "highschooler" ("id", "name", "grade") VALUES (1008, 'Daniel Wagner', 1007);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM highschooler ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(1007,)
(1008,)
*/

-- Prediction Query
SELECT grade FROM Highschooler;

/*
Prediction Result:
(1008,)
(1007,)
*/