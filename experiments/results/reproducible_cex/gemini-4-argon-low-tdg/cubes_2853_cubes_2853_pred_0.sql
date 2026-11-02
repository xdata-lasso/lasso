-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Zoe', 4, 107);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Alice', 4, 107);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Alice', 5, 107);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Clark', 'Bob', 4, 106);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Charlie', 4, 108);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Evans', 'David', 3, NULL);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Taylor', 'Sarah', 106);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 107) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT firstname FROM list WHERE classroom = 107;

/*
Prediction Result:
('Zoe',)
('Alice',)
*/