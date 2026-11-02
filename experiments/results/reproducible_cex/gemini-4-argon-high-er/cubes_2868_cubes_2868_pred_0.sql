-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A', 'A', 2, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B', 'B', 1, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 103) ORDER BY grade;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 103;

/*
Prediction Result:
(2,)
(1,)
*/