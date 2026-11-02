-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 1, 'New York');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Sales Rep', 30000.0, 90000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'asmith@example.com', '111-1111', '2020-01-15', 'J1', 50000.0, 0.1, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Bob', 'Jones', 'bjones@example.com', '222-2222', '2019-03-20', 'J1', 80000.0, 0.15, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Charlie', 'Brown', 'cbrown@example.com', '333-3333', '2021-07-10', 'J1', 80000.0, NULL, 1, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Alice', 'Williams', 'awilliams@example.com', '444-4444', '2022-11-05', 'J1', 60000.0, 0.05, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees ORDER BY salary DESC, Employees.employee_id NULLS LAST;

/*
Gold Result:
('Charlie',)
('Bob',)
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Employees ORDER BY salary ASC, Employees.employee_id NULLS LAST;

/*
Prediction Result:
('Alice',)
('Alice',)
('Charlie',)
('Bob',)
*/