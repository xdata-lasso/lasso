-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (4, 'Marketing', 100, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (5, 'Engineering', 101, 'San Francisco');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (6, 'Sales', 102, 'Chicago');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('ENG', 'Engineer', 40000.0, 90000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@example.com', '111-1111', '2020-01-10', 'ENG', 60000.0, 0.0, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@example.com', '111-2222', '2020-02-15', 'ENG', 50000.0, 0.0, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@example.com', '111-3333', '2020-03-20', 'ENG', 40000.0, 0.0, 101, 5);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Prince', 'diana@example.com', '111-4444', '2020-04-25', 'ENG', 60000.0, 0.0, 100, 4);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Wright', 'evan@example.com', '111-5555', '2020-05-30', 'ENG', 60000.0, 0.0, 102, 6);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Fiona', 'Gallagher', 'fiona@example.com', '111-6666', '2020-06-05', 'ENG', 40000.0, 0.0, 100, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 5 AND salary > 50000;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT first_name FROM Employees;

/*
Prediction Result:
('Alice',)
('Bob',)
('Charlie',)
('Diana',)
('Evan',)
('Fiona',)
*/