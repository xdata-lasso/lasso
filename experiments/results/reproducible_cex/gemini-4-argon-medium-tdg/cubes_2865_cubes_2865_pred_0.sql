-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (boundary values around 105), duplicate elimination (DISTINCT), and sorting (ORDER BY grade).
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 5, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 3, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Charlie', 5, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Wilson', 'Zach', 4, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Alice', 2, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Bob', 6, 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 105) ORDER BY grade;

/*
Gold Result:
(3,)
(4,)
(5,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 105;

/*
Prediction Result:
(5,)
(3,)
(4,)
*/