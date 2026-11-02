-- Schema DDL
CREATE TABLE "list" ("LastName" TEXT, "FirstName" TEXT, "Grade" INTEGER, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

CREATE TABLE "teachers" ("LastName" TEXT, "FirstName" TEXT, "Classroom" INTEGER, PRIMARY KEY ("LastName", "FirstName"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Smith', 'John', 5, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Doe', 'Jane', 5, 105);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Adams', 'Abby', 5, 108);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Zeta', 'Zack', 5, 102);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Brown', 'Charlie', 4, 101);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Davis', 'Emily', 6, 109);
INSERT INTO list (LastName, FirstName, Grade, Classroom) VALUES ('Wilson', 'Will', 4, 5);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Clark', 'Kent', 102);
INSERT INTO teachers (LastName, FirstName, Classroom) VALUES ('Wayne', 'Bruce', 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT classroom FROM list WHERE (grade = 5) ORDER BY classroom;

/*
Gold Result:
(102,)
(105,)
(108,)
*/

-- Prediction Query
SELECT DISTINCT classroom FROM list WHERE grade = 5;

/*
Prediction Result:
(105,)
(108,)
(102,)
*/