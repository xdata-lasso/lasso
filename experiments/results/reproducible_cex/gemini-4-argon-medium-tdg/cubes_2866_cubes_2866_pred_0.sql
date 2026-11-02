-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Zoe', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Jones', 'Amy', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Brown', 'Bob', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('White', 'Dan', 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Black', 'Eve', 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S1', 'A', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S2', 'B', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S3', 'C', 1, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S4', 'D', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S5', 'E', 0, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S6', 'F', 1, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('S7', 'G', 2, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 1)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY firstname;

/*
Gold Result:
('Dan',)
('Zoe',)
*/

-- Prediction Query
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 1;

/*
Prediction Result:
('Zoe',)
('Amy',)
('Eve',)
*/