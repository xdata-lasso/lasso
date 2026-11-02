-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Sales', 2, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Engineering', 10, 'San Francisco');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_ENG', 'Engineer', 4000.0, 9000.0);
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_SLS', 'Salesperson', 800.0, 6000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (20, 'Alice', 'Baker', 'alice@corp.com', '555-0120', '2022-03-15', 'J_ENG', 5000.0, 0.15, 2, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Smith', 'bob@corp.com', '555-0102', '2020-01-10', 'J_ENG', 5000.0, 0.05, NULL, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'Zack', 'Adams', 'zack@corp.com', '555-0110', '2021-06-20', 'J_SLS', 5000.0, 0.25, 2, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Charlie', 'Davis', 'charlie@corp.com', '555-0105', '2019-11-01', 'J_ENG', 5000.25, 0.10, 2, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Diana', 'Evans', 'diana@corp.com', '555-0106', '2023-02-28', 'J_ENG', 5000.75, 0.05, 10, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Evan', 'Ford', 'evan@corp.com', '555-0107', '2021-08-12', 'J_SLS', 900.0, 0.30, 10, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (8, 'Fiona', 'Grant', 'fiona@corp.com', '555-0108', '2018-04-05', 'J_SLS', 1000.0, 0.20, 2, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees ORDER BY salary DESC, Employees.employee_id NULLS LAST;

/*
Gold Result:
('Diana',)
('Charlie',)
('Bob',)
('Zack',)
('Alice',)
('Fiona',)
('Evan',)
*/

-- Prediction Query
SELECT first_name FROM Employees ORDER BY salary ASC, Employees.employee_id NULLS LAST;

/*
Prediction Result:
('Evan',)
('Fiona',)
('Bob',)
('Zack',)
('Alice',)
('Charlie',)
('Diana',)
*/