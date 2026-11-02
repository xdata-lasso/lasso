-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: teachers --
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('lhs_f4bd1d', 'lhs_d9fa9e', 1);

INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('lhs_7d4497', 'lhs_b23c7e', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 1)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY firstname;

/*
Gold Result:
('lhs_b23c7e',)
('lhs_d9fa9e',)
*/

-- Prediction Query
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 1;

/*
Prediction Result:
*/