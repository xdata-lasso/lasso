-- Schema DDL
CREATE TABLE "Highschooler" ("ID" INTEGER PRIMARY KEY, "name" TEXT, "grade" INTEGER);

CREATE TABLE "Friend" ("student_id" INTEGER, "friend_id" INTEGER, PRIMARY KEY ("student_id", "friend_id"), FOREIGN KEY ("friend_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"));

CREATE TABLE "Likes" ("student_id" INTEGER, "liked_id" INTEGER, PRIMARY KEY ("student_id", "liked_id"), FOREIGN KEY ("student_id") REFERENCES "Highschooler" ("ID"), FOREIGN KEY ("liked_id") REFERENCES "Highschooler" ("ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Asymmetric friendships (Joining on student_id vs friend_id).
-- 2. Students with 0 friends (INNER JOIN vs LEFT JOIN).
-- 3. Duplicate names with different friend counts (GROUP BY ID vs GROUP BY name, SELECT DISTINCT, ORDER BY count___ tie-breaker).
-- 4. Decoy Likes table (Using Likes instead of Friend, or unwanted joins with Likes).
-- 5. Anti-correlation between ID, name, grade, and count (ORDER BY name vs other columns, ASC vs DESC).
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (1, 'Zack', 9);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (2, 'Alice', 12);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (3, 'Alice', 10);
INSERT INTO "Highschooler" ("ID", "name", "grade") VALUES (4, 'Bob', 11);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (1, 2);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 1);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 3);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (2, 4);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (3, 1);
INSERT INTO "Friend" ("student_id", "friend_id") VALUES (3, 4);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 1);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (4, 2);
INSERT INTO "Likes" ("student_id", "liked_id") VALUES (1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, n AS count___ FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.grade AS grade, RHS.n AS n FROM highschooler AS LHS INNER JOIN (SELECT student_id, COUNT(*) AS n FROM friend GROUP BY student_id) AS RHS ON (LHS.id = RHS.student_id)) ORDER BY name, count___ NULLS LAST;

/*
Gold Result:
('Alice', 2)
('Alice', 3)
('Zack', 1)
*/

-- Prediction Query
SELECT T2.name, COUNT(*) FROM Friend AS T1 JOIN Highschooler AS T2 ON T1.student_id = T2.id GROUP BY T1.student_id;

/*
Prediction Result:
('Zack', 1)
('Alice', 3)
('Alice', 2)
*/