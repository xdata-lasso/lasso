-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: teachers --
INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('lhs_0c41c9', 'lhs_e5e89b', 1);

INSERT INTO "teachers" ("lastname", "firstname", "classroom") VALUES ('lhs_79914c', 'lhs_80f32c', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 5)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY lastname;

/*
Gold Result:
('lhs_0c41c9',)
('lhs_79914c',)
*/

-- Prediction Query
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 5;

/*
Prediction Result:
*/