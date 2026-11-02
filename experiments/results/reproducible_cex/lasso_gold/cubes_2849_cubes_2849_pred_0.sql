-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('Rogers', 'Christopher', 109);
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('Moore', 'Susan', 109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM teachers WHERE (classroom = 109) ORDER BY lastname, teachers.firstname NULLS LAST;

/*
Gold Result:
('Moore',)
('Rogers',)
*/

-- Prediction Query
SELECT lastname FROM teachers WHERE classroom = 109;

/*
Prediction Result:
('Rogers',)
('Moore',)
*/