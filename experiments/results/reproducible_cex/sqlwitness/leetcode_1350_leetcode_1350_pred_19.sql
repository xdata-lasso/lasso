-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
SELECT S.NAME, S.ID FROM STUDENTS AS S LEFT JOIN DEPARTMENTS AS D ON D.ID = S.DEPARTMENT_ID WHERE D.ID IS NULL;

/*
Prediction Result:
('default1', 0)
*/