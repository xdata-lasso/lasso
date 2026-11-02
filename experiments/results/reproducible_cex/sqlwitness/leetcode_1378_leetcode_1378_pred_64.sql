-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (1, 0), (0, 0), (0, 1);
INSERT INTO employees (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, 'default2')
(1, 'default2')
(0, None)
(None, 'default2')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES LEFT JOIN EMPLOYEEUNI ON IIF(EMPLOYEES.ID = EMPLOYEEUNI.ID, EMPLOYEES.ID, NULL);

/*
Prediction Result:
(None, 'default2')
(0, None)
(None, 'default2')
*/