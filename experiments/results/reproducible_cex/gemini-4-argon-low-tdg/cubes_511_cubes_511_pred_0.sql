-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests duplicates, ordering (inserted out of order), and grades without friends/likes.
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Alice', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Bob', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Charlie', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'David', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (5, 'Eve', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (6, 'Frank', 12);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 2);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 1);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS LEFT JOIN (SELECT grade, COUNT(*) AS n FROM highschooler GROUP BY grade) AS RHS ON (LHS.grade = RHS.grade)) ORDER BY grade;

/*
Gold Result:
(9,)
(10,)
(11,)
(12,)
*/

-- Prediction Query
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4;

/*
Prediction Result:
*/