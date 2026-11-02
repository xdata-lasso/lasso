-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Abbott', 'Cassandra', 1014, 105);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Davis', 'Colin', 1013, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 105) ORDER BY grade;

/*
Gold Result:
(1013,)
(1014,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 105;

/*
Prediction Result:
(1014,)
(1013,)
*/