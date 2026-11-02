-- Schema DDL
CREATE TABLE Employees (emp_id TEXT(5) PRIMARY KEY, emp_name TEXT(20) NOT NULL, dept TEXT(20), wage REAL(8, 2) CHECK (wage > 500));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E0001', 'Alice', 'Engineering', 600.00);
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E0002', 'Bob', 'Engineering', 700.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(600.0,)
*/

-- Prediction Query
SELECT MAX(wage) FROM Employees WHERE dept = 'Engineering';

/*
Prediction Result:
(700.0,)
*/