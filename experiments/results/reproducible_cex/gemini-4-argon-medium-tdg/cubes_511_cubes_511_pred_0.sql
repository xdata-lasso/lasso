-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (101, 'Jordan', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (102, 'Gabriel', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (103, 'Tiffany', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (104, 'Cassandra', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (105, 'Haley', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (106, 'Andrew', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (107, 'Kris', 10);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (101, 102);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (102, 101);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (103, 105);
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