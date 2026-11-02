-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'Amy', 4, 108);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Baker', 'Bob', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Clark', 'Charlie', 4, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Diana', 3, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Evans', 'Evan', 5, 109);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Smith', 'Sam', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Jones', 'Jill', 101);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Brown', 'Betty', 110);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 4) ORDER BY classroom;

/*
Gold Result:
(102,)
(108,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 4;

/*
Prediction Result:
(108,)
(102,)
*/