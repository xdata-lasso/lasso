-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 1, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'John', 1, 107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 107) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('John',)
('John',)
*/

-- Prediction Query
SELECT DISTINCT firstname FROM list WHERE classroom = 107;

/*
Prediction Result:
('John',)
*/