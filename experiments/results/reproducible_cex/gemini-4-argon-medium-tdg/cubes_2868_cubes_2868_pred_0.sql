-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('MR_SMITH', 'JOHN', 103);
INSERT INTO "teachers" ("LastName", "FirstName", "Classroom") VALUES ('MS_JONES', 'MARY', 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('DOE', 'JANE', 5, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('ROE', 'RICHARD', 5, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('POE', 'EDGAR', 2, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('COE', 'SEB', 8, 103);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('LOWE', 'ROB', 1, 102);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('HOE', 'DON', 6, 104);
INSERT INTO "list" ("LastName", "FirstName", "Grade", "Classroom") VALUES ('NOE', 'TIM', 103, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 103) ORDER BY grade;

/*
Gold Result:
(2,)
(5,)
(8,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 103;

/*
Prediction Result:
(5,)
(2,)
(8,)
*/