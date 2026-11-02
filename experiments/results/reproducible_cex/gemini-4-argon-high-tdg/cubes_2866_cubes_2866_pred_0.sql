-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Zack', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Bob', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'Alice', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Davis', 'Charlie', 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Evans', 'David', 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentA', 'One', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentB', 'Two', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentC', 'Three', 1, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentD', 'Four', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentE', 'Five', 2, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentF', 'Six', 0, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 1)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY firstname;

/*
Gold Result:
('David',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T2.firstname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 1;

/*
Prediction Result:
('Zack',)
('Bob',)
*/