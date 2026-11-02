-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Comprehensive boundary values, duplicate names/grades, NULLs, and spurious child table relationships.
-- Kills mutants using >= 9, < 9, OR instead of AND, missing grade <> 10, COUNT(DISTINCT name), COUNT(DISTINCT grade), or unnecessary JOINs with Friend/Likes.
INSERT INTO Highschooler (ID, name, grade) VALUES (1, 'Alice', 8);
INSERT INTO Highschooler (ID, name, grade) VALUES (2, 'Bob', 9);
INSERT INTO Highschooler (ID, name, grade) VALUES (3, 'Charlie', 10);
INSERT INTO Highschooler (ID, name, grade) VALUES (4, 'David', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (5, 'David', 11);
INSERT INTO Highschooler (ID, name, grade) VALUES (6, NULL, 12);
INSERT INTO Highschooler (ID, name, grade) VALUES (7, 'Eve', NULL);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 1);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 2);
INSERT INTO Friend (student_id, friend_id) VALUES (4, 3);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 2);
INSERT INTO Likes (student_id, liked_id) VALUES (4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM highschooler WHERE (grade > 9 AND grade <> 10))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Highschooler WHERE grade = 9 OR grade = 10;

/*
Prediction Result:
(2,)
*/