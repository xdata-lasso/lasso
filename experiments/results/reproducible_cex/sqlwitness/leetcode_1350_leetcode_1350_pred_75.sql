-- Schema DDL
CREATE TABLE "Departments" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "Students" ("id" INTEGER PRIMARY KEY, "name" TEXT(255), "department_id" INTEGER, FOREIGN KEY ("department_id") REFERENCES "Departments" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO students (id, name, department_id) VALUES (0, NULL, NULL), (1, 'default2', NULL);
INSERT INTO departments (id, name) VALUES (0, NULL), (1, NULL), (2, 'default1'), (3, 'default1'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'default2'), (8, NULL), (9, 'default1'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'default2'), (14, NULL), (15, 'default2'), (16, NULL), (17, 'default1'), (18, 'default2'), (19, 'default2'), (20, 'default2'), (21, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name FROM Students WHERE NOT department_id IN (SELECT id FROM departments);

/*
Gold Result:
*/

-- Prediction Query
SELECT S.ID, S.NAME FROM STUDENTS AS S WHERE NOT S.DEPARTMENT_ID IN (SELECT D.ID FROM STUDENTS AS S JOIN DEPARTMENTS AS D ON S.DEPARTMENT_ID = D.ID);

/*
Prediction Result:
(0, None)
(1, 'default2')
*/