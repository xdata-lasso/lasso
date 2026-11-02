-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Smith', 'Zoe', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Adams', 'Bob', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Smith', 'Alice', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Baker', 'Charlie', 108);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Davis', 'Eve', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Evans', 'Frank', NULL);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('StudentA', 'One', 5, 109);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Alice', 4, 108);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM teachers WHERE (classroom = 109) ORDER BY lastname, teachers.firstname NULLS LAST;

/*
Gold Result:
('Adams',)
('Smith',)
('Smith',)
*/

-- Prediction Query
SELECT lastname FROM teachers WHERE classroom = 109;

/*
Prediction Result:
('Smith',)
('Adams',)
('Smith',)
*/