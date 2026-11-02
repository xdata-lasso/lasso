-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (1, NULL, NULL);
INSERT INTO departments (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default1'), (3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT STD.ID AS ID, STD.NAME AS NAME FROM STUDENTS AS STD LEFT JOIN DEPARTMENTS AS DEPT ON STD.DEPARTMENT_ID = DEPT.ID WHERE DEPT.ID IS NULL;

/*
Prediction Result:
(1, None)
*/