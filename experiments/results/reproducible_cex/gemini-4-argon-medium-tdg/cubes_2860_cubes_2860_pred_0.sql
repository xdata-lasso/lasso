-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('TARRING', 'JOHN', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('TARRING', 'MARY', 102);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('SMITH', 'ALICE', 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('DOE', 'JANE', 5, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('BROWN', 'BOB', 5, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('WHITE', 'CHARLIE', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('GREEN', 'DAVID', 4, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('BLACK', 'EVE', 6, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "grade" AS "count___" FROM (SELECT "LHS"."lastname" AS "lastname", "LHS"."firstname" AS "firstname", "LHS"."grade" AS "grade", "LHS"."classroom" AS "classroom", "RHS"."n_distinct" AS "n_distinct" FROM "list" AS "LHS" INNER JOIN (SELECT "classroom", COUNT(DISTINCT "firstname") AS "n_distinct" FROM "teachers" WHERE ("lastname" = 'TARRING') GROUP BY classroom) AS RHS ON (LHS.classroom = RHS.classroom)) ORDER BY count___;

/*
Gold Result:
(2,)
(5,)
*/

-- Prediction Query
SELECT COUNT(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T2.firstname = 'TARRING' AND T2.lastname = 'LEIA';

/*
Prediction Result:
(0,)
*/