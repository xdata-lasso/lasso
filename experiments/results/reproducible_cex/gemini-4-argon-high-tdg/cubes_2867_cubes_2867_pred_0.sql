-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zane', 'Alice', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Bob', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Carol', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'Dave', 104);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentA', 'One', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentB', 'Two', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentC', 'Three', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentD', 'Four', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentE', 'Five', 6, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentF', 'Six', 5, 104);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM (SELECT * FROM teachers AS LHS WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM list WHERE (grade <> 5)) AS RHS WHERE (LHS.classroom = RHS.classroom))) ORDER BY lastname;

/*
Gold Result:
('Clark',)
('Zane',)
*/

-- Prediction Query
SELECT DISTINCT T2.lastname FROM list AS T1 JOIN teachers AS T2 ON T1.classroom = T2.classroom WHERE grade = 5;

/*
Prediction Result:
('Adams',)
('Clark',)
('Zane',)
*/