-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Zeta', 'Alice', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Alpha', 'Zack', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Alpha', 'Aaron', 109);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Beta', 'Charlie', 109);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Zeta', 'Student1', 4, 109);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Alpha', 'Student2', 4, 109);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Alpha', 'Student3', 4, 109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM teachers WHERE (classroom = 109) ORDER BY lastname, teachers.firstname NULLS LAST;

/*
Gold Result:
('Alpha',)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT lastname FROM teachers WHERE classroom = 109;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Alpha',)
('Beta',)
*/