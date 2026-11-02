-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'John', 5, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Baker', 'Alice', 2, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Clark', 'Bob', 5, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Eve', 3, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Evans', 'Tom', 1, 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Frank', 'Sue', 6, 106);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Mark', 105);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Jones', 'Ann', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 105) ORDER BY grade;

/*
Gold Result:
(2,)
(3,)
(5,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 105;

/*
Prediction Result:
(5,)
(2,)
(3,)
*/