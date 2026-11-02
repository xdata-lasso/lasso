-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('A', 'Z', 1);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('B', 'A', 2);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES (NULL, 'A', 1);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES (NULL, 'A', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM teachers ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('A', 'B')
('A', None)
('A', None)
('Z', 'A')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM teachers;

/*
Prediction Result:
('A', None)
('Z', 'A')
('A', 'B')
*/