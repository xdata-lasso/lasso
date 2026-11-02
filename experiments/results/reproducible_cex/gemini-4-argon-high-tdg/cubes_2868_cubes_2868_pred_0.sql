-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 5, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 2, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Charlie', 5, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Taylor', 'Alice', 10, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Wilson', 'Bob', 1, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Moore', 'Eva', 3, 104);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Adams', 'Mary', 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Baker', 'Tom', 102);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT grade FROM list WHERE (classroom = 103) ORDER BY grade;

/*
Gold Result:
(2,)
(5,)
(10,)
*/

-- Prediction Query
SELECT DISTINCT grade FROM list WHERE classroom = 103;

/*
Prediction Result:
(5,)
(2,)
(10,)
*/