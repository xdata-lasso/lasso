-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Zane', 'Alice', 4, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'Alice', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Miller', 'Alice', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'zachary', 5, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'Bob', 0, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Charlie', 1, 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Kirk', 'James', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Picard', 'Jean', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Sisko', 'Benjamin', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Janeway', 'Kathryn', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT firstname, lastname FROM list ORDER BY firstname, list.lastname NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Miller')
('Alice', 'Zane')
('Bob', 'Smith')
('Charlie', 'Brown')
('zachary', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT firstname, lastname FROM list;

/*
Prediction Result:
('Alice', 'Adams')
('Charlie', 'Brown')
('Alice', 'Miller')
('Bob', 'Smith')
('zachary', 'Smith')
('Alice', 'Zane')
*/