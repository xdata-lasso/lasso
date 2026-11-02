-- Schema DDL
CREATE TABLE "Employees" ("id" INTEGER PRIMARY KEY, "name" TEXT(255));

CREATE TABLE "EmployeeUNI" ("id" INTEGER, "unique_id" INTEGER, PRIMARY KEY ("id", "unique_id"), FOREIGN KEY ("id") REFERENCES "Employees" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO employeeuni (id, unique_id) VALUES (2, 0), (0, 1);
INSERT INTO employees (id, name) VALUES (1, 'default2'), (0, 'default1'), (2, 'default1'), (3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e2.unique_id, e1.name FROM employees AS e1 LEFT JOIN employeeUNI AS e2 ON e1.id = e2.id;

/*
Gold Result:
(1, 'default1')
(None, 'default2')
(0, 'default1')
(None, 'default2')
*/

-- Prediction Query
SELECT B.UNIQUE_ID, A.NAME FROM EMPLOYEES AS A LEFT JOIN EMPLOYEEUNI AS B ON B.ID = A.ID ORDER BY 1 DESC, A.id NULLS LAST, B.id NULLS LAST, B.unique_id NULLS LAST;

/*
Prediction Result:
(1, 'default1')
(0, 'default1')
(None, 'default2')
(None, 'default2')
*/