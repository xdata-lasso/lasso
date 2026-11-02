-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zebra', 'Charlie', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Alice', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Bob', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Brown', 'Bob', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'David', 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Davis', 'Eve', 111);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Evans', 'Frank', NULL);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Student', 'Sam', 5, 110);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Pupil', 'Paul', 4, 109);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM teachers WHERE (classroom = 110) ORDER BY firstname, teachers.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Bob',)
('Charlie',)
*/

-- Prediction Query
SELECT firstname FROM teachers WHERE classroom = 110;

/*
Prediction Result:
('Charlie',)
('Alice',)
('Bob',)
('Bob',)
*/