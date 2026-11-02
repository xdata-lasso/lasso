-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic OR condition in "list" and exact match anti-join in "teachers".
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'ALICE', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'BOB', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'CHARLIE', 1, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('DOE', 'DAVID', 2, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'EVE', 3, 105);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('MOYER', 'EVE', 105);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('DOE', 'DAVID', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM (SELECT * FROM (SELECT * FROM "list" WHERE ("lastname" = 'MOYER' OR grade = 1)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM teachers AS RHS WHERE (LHS.lastname = RHS.lastname AND LHS.firstname = RHS.firstname AND LHS.classroom = RHS.classroom))) ORDER BY firstname, "firstname" NULLS LAST, "lastname" NULLS LAST;

/*
Gold Result:
('ALICE', 'MOYER')
('BOB', 'MOYER')
('CHARLIE', 'SMITH')
*/

-- Prediction Query
SELECT DISTINCT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T1.grade = 1 EXCEPT SELECT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T2.firstname = 'OTHA' AND T2.lastname = 'MOYER';

/*
Prediction Result:
*/