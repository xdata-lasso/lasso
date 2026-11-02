-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', 'A', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', 'B', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('C', 'C', 1, 2);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('D', 'D', 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, classroom FROM (SELECT classroom, COUNT(*) AS n FROM list GROUP BY classroom) ORDER BY count___, classroom NULLS LAST;

/*
Gold Result:
(1, 2)
(1, None)
(2, 1)
*/

-- Prediction Query
SELECT COUNT(*), classroom FROM list GROUP BY classroom;

/*
Prediction Result:
(1, None)
(2, 1)
(1, 2)
*/