-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate grades and duplicate names for valid records (grade > 9 AND grade <> 10).
-- Refutes mutants using COUNT(DISTINCT grade), COUNT(DISTINCT name), or GROUP BY grade / name.
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Alice', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Alice', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Bob', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Alice', 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM highschooler WHERE (grade > 9 AND grade <> 10))) ORDER BY count___;

/*
Gold Result:
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Highschooler WHERE grade = 9 OR grade = 10;

/*
Prediction Result:
(0,)
*/