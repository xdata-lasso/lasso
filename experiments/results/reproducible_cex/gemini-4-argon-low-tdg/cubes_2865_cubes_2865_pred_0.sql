-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, deduplication (DISTINCT), ordering (ORDER BY), boundary values around 105, and missing join matches in teachers.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 3, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 1, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Charlie', 3, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Wilson', 'Sam', 2, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Alex', 4, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Anderson', 'Mia', 5, 106);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Davis', 'Sarah', 104);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Miller', 'Tom', 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 105) ORDER BY grade;

/*
Gold Result:
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 105;

/*
Prediction Result:
(3,)
(1,)
(2,)
*/