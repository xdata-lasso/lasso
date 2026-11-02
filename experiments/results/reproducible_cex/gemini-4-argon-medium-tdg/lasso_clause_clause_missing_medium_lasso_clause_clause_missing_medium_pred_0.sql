-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (AVG = 50000), WHERE vs HAVING (employees below 50000 pulling average up/down), and SUM vs AVG.
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'HR', 101, 'NY');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (2, 'IT', 102, 'SF');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (3, 'Sales', 103, 'LA');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (4, 'Marketing', 104, 'CHI');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 30000, 100000);
-- Dept 1: AVG = 50000 (Boundary: should be excluded by > 50000, included if >= 50000)
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'A', 'B', 'a@b.com', '111', '2020-01-01', 'J1', 50000.0, NULL, NULL, 1);
-- Dept 2: Salaries 40000 and 70000. AVG = 55000 (> 50000).
-- Catches mutant with WHERE salary > 50000 (which would compute AVG as 70000).
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'C', 'D', 'c@d.com', '222', '2020-01-01', 'J1', 40000.0, NULL, NULL, 2);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'E', 'F', 'e@f.com', '333', '2020-01-01', 'J1', 70000.0, NULL, NULL, 2);
-- Dept 3: Salaries 30000 and 60000. AVG = 45000 (< 50000), SUM = 90000 (> 50000), MAX = 60000 (> 50000).
-- Catches WHERE salary > 50000 (would include Dept 3 with AVG 60000), HAVING SUM(salary) > 50000, or HAVING MAX(salary) > 50000.
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'G', 'H', 'g@h.com', '444', '2020-01-01', 'J1', 30000.0, NULL, NULL, 3);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'I', 'J', 'i@j.com', '555', '2020-01-01', 'J1', 60000.0, NULL, NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id HAVING AVG(salary) > 50000;

/*
Gold Result:
(2, 55000.0)
*/

-- Prediction Query
SELECT department_id, AVG(salary) FROM Employees GROUP BY department_id;

/*
Prediction Result:
(1, 50000.0)
(2, 55000.0)
(3, 45000.0)
*/