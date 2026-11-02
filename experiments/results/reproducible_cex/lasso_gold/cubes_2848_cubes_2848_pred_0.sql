-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('MOYER', 'Danielle', 1, 1001);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM (SELECT * FROM (SELECT * FROM "list" WHERE ("lastname" = 'MOYER' OR grade = 1)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM teachers AS RHS WHERE (LHS.lastname = RHS.lastname AND LHS.firstname = RHS.firstname AND LHS.classroom = RHS.classroom))) ORDER BY firstname, "firstname" NULLS LAST, "lastname" NULLS LAST;

/*
Gold Result:
('Danielle', 'MOYER')
*/

-- Prediction Query
SELECT DISTINCT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T1.grade = 1 EXCEPT SELECT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T2.firstname = 'OTHA' AND T2.lastname = 'MOYER';

/*
Prediction Result:
*/