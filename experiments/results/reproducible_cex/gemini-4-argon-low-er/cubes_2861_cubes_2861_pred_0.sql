-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Zebra', 'B', 1, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Apple', 'A', 1, 111);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM list WHERE (classroom = 111) ORDER BY lastname, list.firstname NULLS LAST;

/*
Gold Result:
('Apple',)
('Zebra',)
*/

-- Prediction Query
SELECT lastname FROM list WHERE classroom = 111;

/*
Prediction Result:
('Zebra',)
('Apple',)
*/