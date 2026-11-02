-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Zeta', 'Aaron', 4, 111);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Alpha', 'Zach', 4, 111);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'Bob', 4, 111);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'Alice', 4, 111);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Beta', 'Carl', 4, 110);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Gamma', 'Dana', 4, 112);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Turing', 'Alan', 110);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Hopper', 'Grace', 112);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT lastname FROM list WHERE (classroom = 111) ORDER BY lastname, list.firstname NULLS LAST;

/*
Gold Result:
('Alpha',)
('Smith',)
('Smith',)
('Zeta',)
*/

-- Prediction Query
SELECT lastname FROM list WHERE classroom = 111;

/*
Prediction Result:
('Zeta',)
('Alpha',)
('Smith',)
('Smith',)
*/