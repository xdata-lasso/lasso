-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('A', 'Z', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Z', 'A', 110);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM teachers WHERE (classroom = 110) ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('A',)
('Z',)
*/

-- Prediction Query
SELECT firstname FROM teachers WHERE classroom = 110;

/*
Prediction Result:
('Z',)
('A',)
*/