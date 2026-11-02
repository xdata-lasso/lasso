-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('Moore', 'Susan', 110);
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('Rogers', 'Christopher', 110);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM teachers WHERE (classroom = 110) ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Christopher',)
('Susan',)
*/

-- Prediction Query
SELECT firstname FROM teachers WHERE classroom = 110;

/*
Prediction Result:
('Susan',)
('Christopher',)
*/