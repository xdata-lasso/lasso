-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests composite DISTINCT (same classroom with multiple grades, same grade across multiple classrooms, exact duplicates) and basic ordering without NULLs.
-- Also includes an unreferenced classroom in 'teachers' and leaves a classroom in 'list' missing from 'teachers' to kill erroneous JOINs.
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('T_Smith', 'John', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('T_Doe', 'Jane', 999);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S_A', 'One', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S_B', 'Two', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S_C', 'Three', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S_D', 'Four', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('S_E', 'Five', 1, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom, grade NULLS LAST;

/*
Gold Result:
(101, 1)
(101, 2)
(102, 1)
(102, 2)
*/

-- Prediction Query
SELECT DISTINCT classroom, grade FROM list;

/*
Prediction Result:
(102, 2)
(102, 1)
(101, 2)
(101, 1)
*/