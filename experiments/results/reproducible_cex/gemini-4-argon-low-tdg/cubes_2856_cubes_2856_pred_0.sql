-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Charlie', 4, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Alice', 3, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Wilson', 'Bob', 5, 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Mary', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Tom', 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 4) ORDER BY classroom;

/*
Gold Result:
(101,)
(102,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 4;

/*
Prediction Result:
(102,)
(101,)
*/