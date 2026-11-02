-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic WHERE filtering (boundary values around 111, NULLs), duplicate LastNames (to kill DISTINCT mutants), and out-of-order insertion to test ORDER BY lastname.
-- Also omits Classroom 111 from "teachers" to kill mutants that unnecessarily INNER JOIN the teachers table.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Zeta', 'Alice', 5, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Alpha', 'Bob', 4, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Alpha', 'Charlie', 3, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Beta', 'David', 5, 110);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Gamma', 'Eve', 6, 112);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Delta', 'Frank', 2, NULL);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Prof', 'X', 110);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM list WHERE (classroom = 111) ORDER BY lastname, list.firstname NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT lastname FROM list WHERE classroom = 111;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
*/