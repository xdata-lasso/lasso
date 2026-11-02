-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', 'A', 1, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', 'B', 1, 105);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('C', 'C', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('D', 'D', 2, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('E', 'E', 3, NULL);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('F', 'F', 3, NULL);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('G', 'G', 4, 100);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('T1', 'T1', 105);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('T2', 'T2', 105);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('T3', 'T3', 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, classroom FROM (SELECT classroom, COUNT(*) AS n FROM list GROUP BY classroom) ORDER BY count___, classroom NULLS LAST;

/*
Gold Result:
(1, 100)
(2, 101)
(2, 105)
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), classroom FROM list GROUP BY classroom;

/*
Prediction Result:
(2, None)
(1, 100)
(2, 101)
(2, 105)
*/