-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES (NULL, 'Alice', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES (NULL, 'Alice', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM teachers ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Alice', None)
('Alice', None)
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM teachers;

/*
Prediction Result:
('Alice', None)
*/