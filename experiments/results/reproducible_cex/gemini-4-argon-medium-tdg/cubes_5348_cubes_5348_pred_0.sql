-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Smith', 'John', 102);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Doe', 'Jane', 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S1', 'F1', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S2', 'F2', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S3', 'F3', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S4', 'F4', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S5', 'F5', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S6', 'F6', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S7', 'F7', 1, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S8', 'F8', 1, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S9', 'F9', 2, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S10', 'F10', 2, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM (SELECT LHS.classroom AS classroom, LHS.grade AS grade, LHS.n AS n, LHS.maxn AS maxn, RHS.classroom AS classroom_other, RHS.grade AS grade_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS LHS CROSS JOIN (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS RHS) WHERE (n >= maxn AND maxn >= n_other) ORDER BY classroom;

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(103,)
*/