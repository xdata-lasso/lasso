-- Schema DDL
CREATE TABLE Employees (emp_id TEXT(5) PRIMARY KEY, emp_name TEXT(20) NOT NULL, dept TEXT(20), wage REAL(8, 2) CHECK (wage > 500));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Employees" ("emp_id", "emp_name", "dept", "wage") VALUES ('Engineering6', 'Engineering7', 'Engineering', 501);
INSERT INTO "Employees" ("emp_id", "emp_name", "dept", "wage") VALUES ('Engineering5', 'Engineering8', 'Engineering', 502);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(501.0,)
*/

-- Prediction Query
SELECT MAX(wage) FROM Employees WHERE dept = 'Engineering';

/*
Prediction Result:
(502.0,)
*/