-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, 'B', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', 'A', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, 'A', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, 'A', 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('A', 'A')
('A', None)
('A', None)
('B', None)
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
('A', None)
('B', None)
('A', 'A')
*/