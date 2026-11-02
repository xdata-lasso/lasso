-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, 'Alice', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Baker', 'Alice', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Alice', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Clark', NULL, 3, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES (NULL, NULL, 4, 104);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Davis', 'Paul', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
(None, 'Clark')
(None, None)
('Alice', 'Adams')
('Alice', 'Baker')
('Alice', None)
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
(None, None)
('Alice', None)
('Alice', 'Adams')
('Alice', 'Baker')
(None, 'Clark')
*/