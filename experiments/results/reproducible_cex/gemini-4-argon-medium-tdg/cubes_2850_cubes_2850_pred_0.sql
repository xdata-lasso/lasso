-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests DISTINCT removal of duplicate (Classroom, Grade) pairs, basic ordering, and ensures queries erroneously joining with 'teachers' fail due to an empty teachers table.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Charlie', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Emily', 3, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom, grade NULLS LAST;

/*
Gold Result:
(101, 1)
(101, 3)
(102, 2)
*/

-- Prediction Query
SELECT DISTINCT classroom, grade FROM list;

/*
Prediction Result:
(102, 2)
(101, 1)
(101, 3)
*/