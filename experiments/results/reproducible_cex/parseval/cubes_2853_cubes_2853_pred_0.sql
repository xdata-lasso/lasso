-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: list --
INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lis_1f5807', 'lis_a08efd', -55602865, 107);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('lis_f8a8f3', 'lis_a08efd', -59984348, 107);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('G', 'firstname_2', -664303813, 1);

INSERT INTO "list" ("lastname", "firstname", "grade", "classroom") VALUES ('C', 'firstname_3', -1022641847, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 107) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('lis_a08efd',)
('lis_a08efd',)
*/

-- Prediction Query
SELECT DISTINCT firstname FROM list WHERE classroom = 107;

/*
Prediction Result:
('lis_a08efd',)
*/