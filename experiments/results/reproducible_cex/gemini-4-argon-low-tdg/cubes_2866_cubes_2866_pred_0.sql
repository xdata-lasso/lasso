-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Anderson', 'Alice', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Brown', 'Bob', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'Charlie', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Davis', 'David', 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Student1', 'S1', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Student2', 'S2', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Student3', 'S3', 1, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Student4', 'S4', 0, 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 1)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY firstname;

/*
Gold Result:
('Alice',)
('David',)
*/

-- Prediction Query
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 1;

/*
Prediction Result:
('Alice',)
('Charlie',)
*/