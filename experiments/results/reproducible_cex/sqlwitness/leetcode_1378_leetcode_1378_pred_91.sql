-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employees (id, name) VALUES (0, 'default1'), (1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(None, 'default1')
(None, 'default1')
*/

-- Prediction Query
SELECT EMP.NAME, EMPUNI.UNIQUE_ID FROM EMPLOYEES AS EMP LEFT JOIN EMPLOYEEUNI AS EMPUNI ON EMPUNI.ID = EMP.ID;

/*
Prediction Result:
('default1', None)
('default1', None)
*/