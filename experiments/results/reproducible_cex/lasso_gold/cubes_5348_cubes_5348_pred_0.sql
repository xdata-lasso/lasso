-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Fowler', 'Jeffrey', 1001, 1002);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Johnson', 'Jill', 1001, 1002);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Hill', 'Erica', 1001, 1002);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Mcclain', 'Anthony', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Miller', 'Jeffery', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Henderson', 'William', 1003, 1004);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM (SELECT LHS.classroom AS classroom, LHS.grade AS grade, LHS.n AS n, LHS.maxn AS maxn, RHS.classroom AS classroom_other, RHS.grade AS grade_other, RHS.n AS n_other, RHS.maxn AS maxn_other FROM (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS LHS CROSS JOIN (SELECT classroom, grade, n, MAX(n) OVER () AS maxn FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade)) AS RHS) WHERE (n >= maxn AND maxn >= n_other) ORDER BY classroom;

/*
Gold Result:
(1002,)
(1004,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(1002,)
*/