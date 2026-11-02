-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 4, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 4, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 4) ORDER BY classroom;

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 4;

/*
Prediction Result:
(102,)
(101,)
*/