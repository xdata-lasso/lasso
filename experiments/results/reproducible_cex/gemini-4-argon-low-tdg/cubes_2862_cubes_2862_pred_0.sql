-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'John', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'John', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Alice', 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 5, 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM teachers ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Alice', 'Baker')
('John', 'Adams')
('John', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM teachers;

/*
Prediction Result:
('John', 'Adams')
('Alice', 'Baker')
('John', 'Smith')
*/