-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Fowler', 'Angel', 1001, 1002);
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('TARRING', 'Joshua', 1002);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "grade" AS "count___" FROM (SELECT "LHS"."lastname" AS "lastname", "LHS"."firstname" AS "firstname", "LHS"."grade" AS "grade", "LHS"."classroom" AS "classroom", "RHS"."n_distinct" AS "n_distinct" FROM "list" AS "LHS" INNER JOIN (SELECT "classroom", COUNT(DISTINCT "firstname") AS "n_distinct" FROM "teachers" WHERE ("lastname" = 'TARRING') GROUP BY classroom) AS RHS ON (LHS.classroom = RHS.classroom)) ORDER BY count___;

/*
Gold Result:
(1001,)
*/

-- Prediction Query
SELECT COUNT(*) FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T2.firstname = 'TARRING' AND T2.lastname = 'LEIA';

/*
Prediction Result:
(0,)
*/