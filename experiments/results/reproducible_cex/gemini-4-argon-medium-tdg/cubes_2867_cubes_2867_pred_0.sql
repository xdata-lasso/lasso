-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic scenarios:
-- 1. Classroom 101: Only grade 5 students (multiple) -> Should return teacher ('Smith'). Kills INNER JOIN mutants without DISTINCT.
-- 2. Classroom 102: Mixed grades (5 and 4) -> Should NOT return teacher ('Jones'). Kills INNER JOIN WHERE Grade = 5 mutants.
-- 3. Classroom 103: Only non-5 grade (6) -> Should NOT return teacher ('Taylor'). Kills EXISTS / IN mutants.
-- 4. Classroom 104: No students in list -> Should return teacher ('Adams'). Kills INNER JOIN mutants.
-- 5. Ordering: 'Adams' and 'Smith' -> Tests ORDER BY LastName.
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'John', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Jones', 'Alice', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Taylor', 'Bob', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Eve', 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentA', 'One', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentB', 'Two', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentC', 'Three', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentD', 'Four', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentE', 'Five', 6, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 5)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY lastname;

/*
Gold Result:
('Adams',)
('Smith',)
*/

-- Prediction Query
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 5;

/*
Prediction Result:
('Jones',)
('Smith',)
*/