-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULLS LAST vs NULLS FIRST on LastName tie-breaking, NULLS handling on FirstName,
-- and ensures joins with "list" on Classroom = 110 fail if a mutant attempts an INNER JOIN (since "list" has no Classroom 110 here).
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES (NULL, 'Alice', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Smith', 'Alice', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Brown', 'Bob', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Green', NULL, 110);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Tim', 3, 109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM teachers WHERE (classroom = 110) ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT firstname FROM teachers WHERE classroom = 110;

/*
Prediction Result:
('Alice',)
('Alice',)
('Bob',)
(None,)
*/