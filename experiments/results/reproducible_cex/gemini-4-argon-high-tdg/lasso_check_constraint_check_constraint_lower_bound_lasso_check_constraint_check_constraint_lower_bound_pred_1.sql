-- Schema DDL
CREATE TABLE Employees (emp_id TEXT(5) PRIMARY KEY, emp_name TEXT(20) NOT NULL, dept TEXT(20), wage REAL(8, 2) CHECK (wage > 500));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E01', 'Alice', 'Engineering', 1200.75);
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E02', 'Bob', 'Engineering', 600.50);
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E03', 'Charlie', 'Sales', 510.25);
INSERT INTO Employees (emp_id, emp_name, dept, wage) VALUES ('E04', 'David', 'HR', 505.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT MIN(wage) FROM Employees WHERE dept = 'Engineering';

/*
Gold Result:
(600.5,)
*/

-- Prediction Query
SELECT MIN(wage) FROM Employees;

/*
Prediction Result:
(505.0,)
*/