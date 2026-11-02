-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (0, 2);
INSERT INTO employees (id, name) VALUES (2, 'default2'), (0, NULL), (1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(2, None)
(None, 'default2')
(None, 'default2')
*/

-- Prediction Query
SELECT COALESCE(T2.UNIQUE_ID, NULL) AS UNIQUE_ID, T1.NAME FROM EMPLOYEES AS T1 LEFT JOIN EMPLOYEEUNI AS T2 ON T1.ID = T2.ID ORDER BY 2, T1.id NULLS LAST, T2.id NULLS LAST, T2.unique_id NULLS LAST;

/*
Prediction Result:
(2, None)
(None, 'default2')
(None, 'default2')
*/