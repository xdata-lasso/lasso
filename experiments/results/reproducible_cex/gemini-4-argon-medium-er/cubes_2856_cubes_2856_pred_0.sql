-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', 'B', 4, 2);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('C', 'D', 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 4) ORDER BY classroom;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 4;

/*
Prediction Result:
(2,)
(1,)
*/