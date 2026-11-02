-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Smith', 'John', 5, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Doe', 'Jane', 5, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Brown', 'Bob', 5, 101);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Taylor', 'Alice', 4, 100);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('Wilson', 'Charlie', 6, 103);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Adams', 'Sarah', 101);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('Clark', 'Mike', 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 5) ORDER BY classroom;

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 5;

/*
Prediction Result:
(102,)
(101,)
*/