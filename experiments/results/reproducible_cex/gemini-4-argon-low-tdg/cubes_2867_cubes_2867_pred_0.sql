-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests core logic:
-- 1. Teacher with no students in classroom (Classroom 100) -> Included
-- 2. Teacher with only Grade 5 students (Classroom 101) -> Included
-- 3. Teacher with multiple Grade 5 students (Classroom 102) -> Included (tests DISTINCT vs non-DISTINCT joins)
-- 4. Teacher with both Grade 5 and Grade 4 students (Classroom 103) -> Excluded (tests universal vs existential quantification)
-- 5. Teacher with only Grade 6 students (Classroom 104) -> Excluded (tests boundary > 5)
-- 6. Multiple teachers with the same LastName ('Smith') -> Both included (tests SELECT DISTINCT mutations)
-- 7. Ordering of LastName ('Adams', 'Baker', 'Smith', 'Smith', 'Zane')
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zane', 'Alice', 100);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Bob', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Charlie', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'David', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Davis', 'Eve', 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Frank', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Grace', 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S1', 'F1', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S2', 'F2', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S3', 'F3', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S4', 'F4', 5, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S5', 'F5', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S6', 'F6', 6, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 5)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY lastname;

/*
Gold Result:
('Adams',)
('Baker',)
('Smith',)
('Smith',)
('Zane',)
*/

-- Prediction Query
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 5;

/*
Prediction Result:
('Adams',)
('Baker',)
('Clark',)
('Smith',)
*/