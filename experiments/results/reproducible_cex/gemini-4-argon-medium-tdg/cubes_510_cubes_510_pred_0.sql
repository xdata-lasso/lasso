-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard execution where ordering by ID, name, and grade (ASC vs DESC) all produce distinct top-1 results.
-- Also includes disconnected rows in Friend and Likes to catch mutants that erroneously join on those tables.
-- Gold Query result: 11 (from 'Zack', who has the highest name alphabetically, though neither the highest/lowest ID nor highest/lowest grade).
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (10, 'Zack', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (20, 'Alice', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (5, 'Bob', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (30, 'Charlie', 10);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (20, 5);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (5, 20);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (30, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT grade FROM (SELECT * FROM (SELECT * FROM (SELECT id, name, grade, COUNT(*) OVER () AS n FROM highschooler) ORDER BY name DESC) LIMIT 1);

/*
Gold Result:
(11,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC, grade NULLS LAST LIMIT 1;

/*
Prediction Result:
(9,)
*/