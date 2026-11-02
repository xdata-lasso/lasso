-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Rogers', 'Christopher', 1013, 111);
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('Davis', 'Melanie', 1014, 111);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM list WHERE (classroom = 111) ORDER BY lastname, list.firstname NULLS LAST;

/*
Gold Result:
('Davis',)
('Rogers',)
*/

-- Prediction Query
SELECT lastname FROM list WHERE classroom = 111;

/*
Prediction Result:
('Rogers',)
('Davis',)
*/