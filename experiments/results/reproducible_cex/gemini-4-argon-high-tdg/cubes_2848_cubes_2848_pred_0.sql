-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'Alice', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'Bob', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'Charlie', 0, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'David', 1, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'Eve', 2, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'Frank', 0, 106);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'Grace', 1, 107);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('SMITH', 'Heidi', 1, 108);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('MOYER', 'Ivan', 3, 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('MOYER', 'Grace', 107);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('SMITH', 'Heidi', 108);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('MOYER', 'Ivan', 109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "firstname", "lastname" FROM (SELECT * FROM (SELECT * FROM "list" WHERE ("lastname" = 'MOYER' OR grade = 1)) AS LHS WHERE NOT EXISTS(SELECT 1 FROM teachers AS RHS WHERE (LHS.lastname = RHS.lastname AND LHS.firstname = RHS.firstname AND LHS.classroom = RHS.classroom))) ORDER BY firstname, "firstname" NULLS LAST, "lastname" NULLS LAST;

/*
Gold Result:
('Alice', 'MOYER')
('Bob', 'MOYER')
('Charlie', 'MOYER')
('David', 'SMITH')
*/

-- Prediction Query
SELECT DISTINCT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T1.grade = 1 EXCEPT SELECT T1.firstname, T1.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE T2.firstname = 'OTHA' AND T2.lastname = 'MOYER';

/*
Prediction Result:
('Grace', 'MOYER')
('Heidi', 'SMITH')
*/