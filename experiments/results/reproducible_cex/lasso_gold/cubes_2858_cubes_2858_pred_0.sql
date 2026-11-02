-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Davis', 'Melanie', 1013, 108);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Rogers', 'Christopher', 1014, 108);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 108) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Christopher',)
('Melanie',)
*/

-- Prediction Query
SELECT firstname FROM list WHERE classroom = 108;

/*
Prediction Result:
('Melanie',)
('Christopher',)
*/