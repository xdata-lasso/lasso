-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (1, 'Sales', 101, 'New York');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (2, 'Marketing', 102, 'Chicago');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J_REP', 'Representative', 30000.0, 80000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Brown', 'alice@test.com', '111-1111', '2020-01-10', 'J_REP', 49999.99, 0.0, 101, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Davis', 'bob@test.com', '111-2222', '2020-02-15', 'J_REP', 50000.0, 0.0, 101, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Evans', 'charlie@test.com', '111-3333', '2020-03-20', 'J_REP', 50000.01, 0.0, 102, 2);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'Diana', 'Foster', 'diana@test.com', '111-4444', '2020-04-25', 'J_REP', 60000.0, 0.0, 101, 1);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Evan', 'Green', 'evan@test.com', '111-5555', '2020-05-30', 'J_REP', NULL, 0.0, 102, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.first_name, e.last_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Gold Result:
('Charlie', 'Evans', 'Marketing')
('Diana', 'Foster', 'Sales')
*/

-- Prediction Query
SELECT e.first_name, first_name, d.department_name FROM Employees AS e JOIN Departments AS d ON e.department_id = d.department_id WHERE e.salary > 50000;

/*
Prediction Result:
('Charlie', 'Charlie', 'Marketing')
('Diana', 'Diana', 'Sales')
*/