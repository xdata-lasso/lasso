-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('A', 'A', NULL, 2);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('B', 'B', 1, 1);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('C', 'C', NULL, 1);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('D', 'D', 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom, grade NULLS LAST;

/*
Gold Result:
(1, 1)
(1, 2)
(1, None)
(2, None)
*/

-- Prediction Query
SELECT DISTINCT classroom, grade FROM list;

/*
Prediction Result:
(2, None)
(1, 1)
(1, None)
(1, 2)
*/