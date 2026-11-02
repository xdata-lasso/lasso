-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('COVIN', 'JOHN', 4, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('COVIN', 'JANE', 3, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'ALICE', 3, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('DOE', 'BOB', 5, 104);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('DOE', 'BOB', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lastname" FROM (SELECT * FROM (SELECT * FROM "list" WHERE ("lastname" = 'COVIN' OR grade = 3)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM teachers AS RHS WHERE (LHS.lastname = RHS.lastname AND LHS.firstname = RHS.firstname AND LHS.classroom = RHS.classroom))) ORDER BY lastname, "lastname" NULLS LAST;

/*
Gold Result:
('COVIN',)
('COVIN',)
('SMITH',)
*/

-- Prediction Query
SELECT DISTINCT T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T1.grade = 3 AND T2.firstname <> 'COVIN' AND T2.lastname <> 'JEROME';

/*
Prediction Result:
*/