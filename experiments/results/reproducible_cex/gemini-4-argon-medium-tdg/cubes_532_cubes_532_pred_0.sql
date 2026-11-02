-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Students with the same name but different IDs and friend counts (kills GROUP BY name instead of ID).
-- 2. Students with 0 friends (kills LEFT JOIN instead of INNER JOIN).
-- 3. Asymmetric friendships (kills joining on friend_id instead of student_id).
-- 4. Different data in Likes table (kills querying Likes instead of Friend).
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Alice', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Alice', 11);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Bob', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Charlie', 12);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 2);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 3);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 3);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (3, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 1);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 2);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 1)
('Alice', 2)
('Bob', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
('Alice', 2)
('Alice', 1)
('Bob', 1)
*/