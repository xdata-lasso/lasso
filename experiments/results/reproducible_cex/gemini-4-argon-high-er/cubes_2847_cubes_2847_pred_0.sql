-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A', 'A', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B', 'B', 5, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 5) ORDER BY classroom;

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 5;

/*
Prediction Result:
(102,)
(101,)
*/