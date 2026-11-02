-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Abbott', 'Cassandra', 5, 1014);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Davis', 'Colin', 5, 1013);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 5) ORDER BY classroom;

/*
Gold Result:
(1013,)
(1014,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 5;

/*
Prediction Result:
(1014,)
(1013,)
*/