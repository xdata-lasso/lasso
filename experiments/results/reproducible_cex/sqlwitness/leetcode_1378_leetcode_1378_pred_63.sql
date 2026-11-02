-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (0, 0);
INSERT INTO employees (id, name) VALUES (1, 'default2'), (0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, 'default1')
(None, 'default2')
*/

-- Prediction Query
SELECT UNIQUE_ID, NAME FROM EMPLOYEES AS E1 LEFT JOIN EMPLOYEEUNI AS E2 ON E1.ID = E2.ID ORDER BY NAME, E1.id NULLS LAST, E2.id NULLS LAST, E2.unique_id NULLS LAST;

/*
Prediction Result:
(0, 'default1')
(None, 'default2')
*/