-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('A', 'A', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('B', 'B', 1, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('C', 'C', 2, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('D', 'D', 2, 1);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('E', 'E', 1, 2);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('F', 'F', 1, 2);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('G', 'G', 1, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/