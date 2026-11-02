-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Finance', 1, 'Boston');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'HR', 5, 'Austin');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('FIN', 'Analyst', 2000.0, 6000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'EmpA', 'LastA', 'a@ex.com', '222-1111', '2020-01-01', 'FIN', 5000.0, 0.10, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'EmpB', 'LastB', 'b@ex.com', '222-2222', '2020-02-01', 'FIN', 5000.0, 0.10, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'EmpC', 'LastC', 'c@ex.com', '222-3333', '2020-03-01', 'FIN', 3000.0, 0.05, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'EmpD', 'LastD', 'd@ex.com', '222-4444', '2020-04-01', 'FIN', 3000.0, 0.05, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'EmpE', 'LastE', 'e@ex.com', '222-5555', '2020-05-01', 'FIN', 4000.0, 0.00, NULL, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'EmpF', 'LastF', 'f@ex.com', '222-6666', '2020-06-01', 'FIN', 4000.0, 0.00, 5, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'EmpG', 'LastG', 'g@ex.com', '222-7777', '2020-07-01', 'FIN', 4000.0, 0.00, 5, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT employee_id, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Gold Result:
(1, 1)
(2, 2)
(3, 3)
(4, 4)
(5, 1)
(6, 2)
(7, 3)
*/

-- Prediction Query
SELECT employee_id, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) FROM Employees;

/*
Prediction Result:
(1, 1)
(2, 1)
(3, 3)
(4, 3)
(5, 1)
(6, 1)
(7, 1)
*/