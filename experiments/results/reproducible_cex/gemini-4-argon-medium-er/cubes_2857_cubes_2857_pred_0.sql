-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, NULL, 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, NULL, 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Zack', 3, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Alice', 4, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
('Alice', 'Adams')
('Zack', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
(None, None)
('Alice', 'Adams')
('Zack', 'Smith')
*/