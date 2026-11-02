-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (FirstName ASC, then LastName ASC), reversed insertion order,
-- duplicate FirstNames (tie-breaking on LastName), and duplicate LastNames (detecting SELECT DISTINCT on subsets).
-- Also includes an unmatched classroom and a multiple-teacher classroom to kill incorrect JOIN mutants.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Zane', 'Alice', 5, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Alice', 3, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Baker', 'Bob', 4, 999);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Charlie', 2, 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Smith', 'John', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Doe', 'Jane', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Brown', 'Bob', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Zane')
('Bob', 'Baker')
('Charlie', 'Adams')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
('Alice', 'Adams')
('Charlie', 'Adams')
('Bob', 'Baker')
('Alice', 'Zane')
*/