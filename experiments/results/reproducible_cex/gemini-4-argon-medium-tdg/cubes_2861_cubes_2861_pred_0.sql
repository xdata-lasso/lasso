-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Zoe', 4, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Adam', 3, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'John', 5, 111);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Baker', 'Alice', 4, 110);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Clark', 'Bob', 4, 112);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Eve', 4, NULL);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('TeacherA', 'One', 110);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('TeacherB', 'Two', 112);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM list WHERE (classroom = 111) ORDER BY lastname, list.firstname NULLS LAST;

/*
Gold Result:
('Adams',)
('Smith',)
('Smith',)
*/

-- Prediction Query
SELECT lastname FROM list WHERE classroom = 111;

/*
Prediction Result:
('Smith',)
('Smith',)
('Adams',)
*/