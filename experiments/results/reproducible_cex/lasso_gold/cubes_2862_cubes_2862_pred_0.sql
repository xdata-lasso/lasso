-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES (NULL, 'Jeffrey', 1002);
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES (NULL, 'Jeffrey', 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM teachers ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Jeffrey', None)
('Jeffrey', None)
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM teachers;

/*
Prediction Result:
('Jeffrey', None)
*/