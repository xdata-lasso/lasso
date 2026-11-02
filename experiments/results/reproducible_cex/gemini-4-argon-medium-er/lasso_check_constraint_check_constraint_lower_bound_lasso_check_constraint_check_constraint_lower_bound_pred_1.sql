-- Schema DDL
CREATE TABLE Employees (emp_id TEXT(5) PRIMARY KEY, emp_name TEXT(20) NOT NULL, dept TEXT(20), wage REAL(8, 2) CHECK (wage > 500));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E0001', 'Alice', 'Sales', 600.00);
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E0002', 'Bob', 'Engineering', 1000.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(1000.0,)
*/

-- Prediction Query
SELECT MIN(wage) FROM Employees;

/*
Prediction Result:
(600.0,)
*/