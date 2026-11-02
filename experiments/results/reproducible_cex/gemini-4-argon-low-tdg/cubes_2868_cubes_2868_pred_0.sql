-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 5, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 5, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Charlie', 2, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Wilson', 'Alice', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Bob', 6, 104);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Adams', 'Sarah', 102);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Davis', 'Mike', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 103) ORDER BY grade;

/*
Gold Result:
(2,)
(5,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 103;

/*
Prediction Result:
(5,)
(2,)
*/