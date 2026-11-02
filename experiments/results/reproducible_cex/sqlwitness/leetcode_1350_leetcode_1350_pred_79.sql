-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
(0, 'default2')
*/

-- Prediction Query
WITH A AS (SELECT DEPARTMENT_ID FROM STUDENTS WHERE NOT DEPARTMENT_ID IN (SELECT ID FROM DEPARTMENTS GROUP BY 1) GROUP BY 1) SELECT ID, NAME FROM A JOIN STUDENTS AS B ON A.DEPARTMENT_ID = B.DEPARTMENT_ID GROUP BY 1, 2;

/*
Prediction Result:
*/