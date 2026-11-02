-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Zeta', 'Bob', 4, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Alpha', 'Alice', 4, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Beta', 'Alice', 5, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Gamma', 'Charlie', 4, 106);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Delta', 'David', 4, 108);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Epsilon', 'Eve', 4, NULL);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Omega', 'Frank', 107, 105);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'John', 107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 107) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Bob',)
*/

-- Prediction Query
SELECT DISTINCT firstname FROM list WHERE classroom = 107;

/*
Prediction Result:
('Bob',)
('Alice',)
*/