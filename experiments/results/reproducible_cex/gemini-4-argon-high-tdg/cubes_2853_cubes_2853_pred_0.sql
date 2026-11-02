-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'Zack', 4, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Baker', 'Alice', 5, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Clark', 'Alice', 3, 107);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Bob', 4, 106);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Evans', 'Charlie', 5, 108);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'John', 107);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Jones', 'Mary', 107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname FROM list WHERE (classroom = 107) ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT firstname FROM list WHERE classroom = 107;

/*
Prediction Result:
('Zack',)
('Alice',)
*/