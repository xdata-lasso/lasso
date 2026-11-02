-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (ASC vs DESC), duplicates (SELECT vs SELECT DISTINCT), and absence of rows in Friend/Likes (catches unnecessary INNER JOINs).
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Alice', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Bob', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Charlie', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'David', 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM highschooler ORDER BY grade, highschooler.id NULLS LAST;

/*
Gold Result:
(9,)
(9,)
(11,)
(12,)
*/

-- Prediction Query
SELECT grade FROM Highschooler;

/*
Prediction Result:
(12,)
(9,)
(11,)
(9,)
*/