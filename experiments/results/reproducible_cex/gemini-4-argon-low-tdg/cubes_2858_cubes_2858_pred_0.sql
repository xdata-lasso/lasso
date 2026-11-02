-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering (108 vs boundaries 107, 109, and NULL), duplicate FirstName preservation (SELECT vs SELECT DISTINCT), and primary ORDER BY FirstName.
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'Zoe', 4, 108);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Adams', 'Alice', 5, 108);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Alice', 3, 108);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Clark', 'Bob', 4, 107);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Davis', 'Charlie', 4, 109);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Evans', 'David', 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 108) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT firstname FROM list WHERE classroom = 108;

/*
Prediction Result:
('Zoe',)
('Alice',)
('Alice',)
*/