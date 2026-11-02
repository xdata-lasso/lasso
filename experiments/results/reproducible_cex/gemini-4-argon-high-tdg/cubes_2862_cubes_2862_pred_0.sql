-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentZ', 'Zack', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentY', 'Yara', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentX', 'Xavier', 2, 999);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zane', 'Alice', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Bob', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Alice', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Alice', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM teachers ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Baker')
('Alice', 'Zane')
('Bob', 'Adams')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM teachers;

/*
Prediction Result:
('Alice', 'Adams')
('Bob', 'Adams')
('Alice', 'Baker')
('Alice', 'Zane')
*/