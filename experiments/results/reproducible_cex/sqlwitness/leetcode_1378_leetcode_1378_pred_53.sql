-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (0, 1), (1, 0), (1, 1), (0, 0);
INSERT INTO employees (id, name) VALUES (0, 'default2'), (1, 'default1'), (2, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, 'default2')
(1, 'default2')
(0, 'default1')
(1, 'default1')
(None, 'default2')
*/

-- Prediction Query
SELECT COALESCE(NULL, EU.UNIQUE_ID) AS UNIQUE_ID, E.NAME FROM EMPLOYEES AS E LEFT JOIN EMPLOYEEUNI AS EU ON E.ID = EU.ID ORDER BY UNIQUE_ID DESC, E.id NULLS LAST, EU.id NULLS LAST;

/*
Prediction Result:
(1, 'default2')
(1, 'default1')
(0, 'default2')
(0, 'default1')
(None, 'default2')
*/