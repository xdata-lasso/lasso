-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Hill', 'Jeffrey', 1003, 1004);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Henderson', 'Anthony', 1008, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, classroom FROM (SELECT classroom, COUNT(*) AS n FROM list GROUP BY classroom) ORDER BY count___, classroom NULLS LAST;

/*
Gold Result:
(1, 1004)
(1, None)
*/

-- Prediction Query
SELECT COUNT(*), classroom FROM list GROUP BY classroom;

/*
Prediction Result:
(1, None)
(1, 1004)
*/