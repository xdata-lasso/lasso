-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Anderson', 'Alice', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Bob', 1, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Carter', 'Charlie', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Diana', 2, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Evans', 'Evan', 3, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Foster', 'Fiona', 3, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Garcia', 'George', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Harris', 'Hannah', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Irwin', 'Ian', 2, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Jackson', 'Julia', 4, 103);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('King', 'Kevin', 4, 103);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Miller', 'Mary', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Nelson', 'Nancy', 103);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT classroom FROM (SELECT * FROM (SELECT * FROM (SELECT classroom, grade, COUNT(*) AS n FROM list GROUP BY classroom, grade) ORDER BY n DESC) LIMIT 1);

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT classroom FROM list GROUP BY classroom ORDER BY COUNT(*) DESC, classroom NULLS LAST LIMIT 1;

/*
Prediction Result:
(101,)
*/