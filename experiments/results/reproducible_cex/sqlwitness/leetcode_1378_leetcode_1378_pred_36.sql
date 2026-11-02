-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (0, 0), (1, 1), (1, 0);
INSERT INTO employees (id, name) VALUES (1, NULL), (0, NULL), (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(0, None)
(0, None)
(1, None)
(None, None)
*/

-- Prediction Query
SELECT (SELECT UNIQUE_ID FROM EMPLOYEEUNI AS U WHERE U.ID = E.ID) AS UNIQUE_ID, NAME FROM EMPLOYEES AS E;

/*
Prediction Result:
(0, None)
(0, None)
(None, None)
*/