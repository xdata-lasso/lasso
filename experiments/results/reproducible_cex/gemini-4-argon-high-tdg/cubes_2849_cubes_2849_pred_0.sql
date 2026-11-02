-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Zimmerman', 'Paul', 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Miller', 'Anna', 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'John', 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Alice', 108);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Carter', 'Bob', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Evans', 'Grace', NULL);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentZ', 'One', 5, 109);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentA', 'Two', 5, 109);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('StudentB', 'Three', 4, 108);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM teachers WHERE (classroom = 109) ORDER BY lastname, teachers.firstname NULLS LAST;

/*
Gold Result:
('Adams',)
('Miller',)
('Zimmerman',)
*/

-- Prediction Query
SELECT lastname FROM teachers WHERE classroom = 109;

/*
Prediction Result:
('Zimmerman',)
('Miller',)
('Adams',)
*/