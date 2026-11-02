-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests standard GROUP BY (classroom, grade), ORDER BY n DESC, LIMIT 1.
-- Kills mutants that omit GROUP BY grade (Classroom 101 has total 4 across two grades, while 102 has 3 in one grade),
-- mutants that omitGROUP BY classroom (Grade 3 has total 4 across two classrooms, while Grade 4 has 3 in one classroom),
-- mutants that use ASC instead of DESC, and mutants that omit LIMIT 1.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Bob', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Alice', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Wilson', 'Charlie', 3, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Eve', 3, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Anderson', 'Frank', 3, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Thomas', 'Grace', 3, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Moore', 'Hank', 4, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Jackson', 'Ivy', 4, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('White', 'Jack', 4, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Harris', 'Karl', 5, 105);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Mr', 'A', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Ms', 'B', 102);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Mrs', 'C', 103);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Dr', 'D', 104);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Prof', 'E', 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(101,)
*/