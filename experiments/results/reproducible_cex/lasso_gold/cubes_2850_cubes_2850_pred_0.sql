-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Henderson', 'Anthony', 1005, 1007);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Mcclain', 'Christopher', 1006, 1006);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom, grade NULLS LAST;

/*
Gold Result:
(1006, 1006)
(1007, 1005)
*/

-- Prediction Query
SELECT DISTINCT classroom, grade FROM list;

/*
Prediction Result:
(1007, 1005)
(1006, 1006)
*/