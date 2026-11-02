-- Schema DDL
CREATE TABLE sales (id INTEGER PRIMARY KEY, department TEXT, employee_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("id", "department", "employee_id") VALUES (5, NULL, 8);
INSERT INTO "sales" ("id", "department", "employee_id") VALUES (4, NULL, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department, COUNT(DISTINCT employee_id) FROM sales GROUP BY department;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT department, COUNT(employee_id) FROM sales GROUP BY department;

/*
Prediction Result:
(None, 2)
*/