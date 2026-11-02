-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 5, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Mark', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'Alice', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Baker', 'Alice', 2, 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('lee', 'nancy', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('king', 'robert', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('hall', 'susan', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, classroom FROM (SELECT classroom, COUNT(*) AS n FROM list GROUP BY classroom) ORDER BY count___, classroom NULLS LAST;

/*
Gold Result:
(1, 103)
(2, 101)
(2, 102)
*/

-- Prediction Query
SELECT COUNT(*), classroom FROM list GROUP BY classroom;

/*
Prediction Result:
(2, 101)
(2, 102)
(1, 103)
*/