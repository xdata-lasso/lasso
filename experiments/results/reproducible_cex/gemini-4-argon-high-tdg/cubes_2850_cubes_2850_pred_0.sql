-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 10, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Charlie', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Taylor', 'Alice', 5, 10);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Wilson', 'Bob', 2, 2);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Eve', 10, 2);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'Kent', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Wayne', 'Bruce', 999);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom, grade FROM list ORDER BY classroom, grade NULLS LAST;

/*
Gold Result:
(2, 2)
(2, 10)
(10, 5)
(102, 2)
(102, 10)
*/

-- Prediction Query
SELECT DISTINCT classroom, grade FROM list;

/*
Prediction Result:
(102, 10)
(102, 2)
(10, 5)
(2, 2)
(2, 10)
*/