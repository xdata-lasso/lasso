-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (0, 0), (0, 1);
INSERT INTO employees (id, name) VALUES (1, 'default2'), (0, NULL), (2, NULL), (3, NULL), (4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, None)
(1, None)
(None, 'default2')
(None, None)
(None, None)
(None, 'default2')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS EU ON E.ID = EU.ID ORDER BY UNIQUE_ID, E.id NULLS LAST, EU.id NULLS LAST;

/*
Prediction Result:
(None, 'default2')
(None, None)
(None, None)
(None, 'default2')
(0, None)
(1, None)
*/