-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic boundary conditions (9, 10, 11), NULL department_id, and column confusion (employee_id=10 vs manager_id=10 vs department_id=10)
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (9, 'Dept 9', 100, 'Loc A');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Dept 10', 100, 'Loc B');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (11, 'Dept 11', 100, 'Loc C');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Dev', 50000.0, 100000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@test.com', '111', '2020-01-01', 'J1', 60000.0, NULL, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@test.com', '222', '2020-01-02', 'J1', 60000.0, NULL, 100, 9);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@test.com', '333', '2020-01-03', 'J1', 60000.0, NULL, 100, 11);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'White', 'david@test.com', '444', '2020-01-04', 'J1', 60000.0, NULL, 10, NULL);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (10, 'Eve', 'Black', 'eve@test.com', '555', '2020-01-05', 'J1', 10.0, 10.0, 100, 9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10;

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT * FROM Departments;

/*
Prediction Result:
(9, 'Dept 9', 100, 'Loc A')
(10, 'Dept 10', 100, 'Loc B')
(11, 'Dept 11', 100, 'Loc C')
*/