-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', '1', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', '2', 1, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', '1', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', '2', 2, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', '3', 3, 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(101,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(102,)
*/