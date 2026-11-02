-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES (NULL, 'Jeffrey', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES (NULL, 'Jeffrey', 1005, 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Jeffrey', None)
('Jeffrey', None)
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
('Jeffrey', None)
*/