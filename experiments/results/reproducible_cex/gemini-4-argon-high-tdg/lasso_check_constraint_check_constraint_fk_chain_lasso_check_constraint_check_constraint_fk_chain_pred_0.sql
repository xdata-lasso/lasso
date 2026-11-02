-- Schema DDL
CREATE TABLE Departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT(20) NOT NULL, budget REAL(12, 2) CHECK (budget > 0));

CREATE TABLE Projects (proj_id INTEGER PRIMARY KEY, proj_name TEXT(30) NOT NULL, dept_id INTEGER, budget_allocated REAL(10, 2), FOREIGN KEY (dept_id) REFERENCES Departments (dept_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (dept_id, dept_name, budget) VALUES (1, 'Engineering', 50000.00);
INSERT INTO Projects (proj_id, proj_name, dept_id, budget_allocated) VALUES (1, 'Proj_Below_Bound', 1, 9999.99);
INSERT INTO Projects (proj_id, proj_name, dept_id, budget_allocated) VALUES (2, 'Proj_Exact_Bound', 1, 10000.00);
INSERT INTO Projects (proj_id, proj_name, dept_id, budget_allocated) VALUES (3, 'Proj_Above_Bound', 1, 10000.01);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT proj_name FROM Projects WHERE budget_allocated > 10000;

/*
Gold Result:
('Proj_Above_Bound',)
*/

-- Prediction Query
SELECT proj_name FROM Projects WHERE budget_allocated < 10000;

/*
Prediction Result:
('Proj_Below_Bound',)
*/