-- Schema DDL
CREATE TABLE Departments (department_id INTEGER PRIMARY KEY, department_name TEXT, manager_id INTEGER, location TEXT);

CREATE TABLE Employees (employee_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT, email TEXT, phone TEXT, hire_date DATE, job_id TEXT, salary REAL, commission_pct REAL, manager_id INTEGER, department_id INTEGER, FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

CREATE TABLE Jobs (job_id TEXT PRIMARY KEY, job_title TEXT, min_salary REAL, max_salary REAL);

CREATE TABLE JobHistory (employee_id INTEGER, start_date DATE, end_date DATE, job_id TEXT, department_id INTEGER, FOREIGN KEY (employee_id) REFERENCES Employees (employee_id), FOREIGN KEY (department_id) REFERENCES Departments (department_id), FOREIGN KEY (job_id) REFERENCES Jobs (job_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (9, 'Dept 9', 100, 'Loc A');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (10, 'Dept 10', 100, 'Loc B');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (11, 'Dept 11', 100, 'Loc C');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (15, 'Dept 15', 100, 'Loc D');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (19, 'Dept 19', 100, 'Loc E');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (20, 'Dept 20', 100, 'Loc F');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (21, 'Dept 21', 100, 'Loc G');
INSERT INTO Departments (department_id, department_name, manager_id, location) VALUES (30, 'Dept 30', 100, 'Loc H');
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES ('J1', 'Developer', 40000.0, 90000.0);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (1, 'Alice', 'Smith', 'alice@test.com', '111-1111', '2020-01-01', 'J1', 50000.0, 0.1, 100, 9);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (2, 'Bob', 'Jones', 'bob@test.com', '111-1112', '2020-01-02', 'J1', 51000.0, 0.1, 100, 10);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (3, 'Charlie', 'Brown', 'charlie@test.com', '111-1113', '2020-01-03', 'J1', 52000.0, 0.1, 100, 11);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (4, 'David', 'Wilson', 'david@test.com', '111-1114', '2020-01-04', 'J1', 53000.0, 0.1, 100, 15);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (5, 'Eve', 'Davis', 'eve@test.com', '111-1115', '2020-01-05', 'J1', 54000.0, 0.1, 100, 19);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (6, 'Frank', 'Miller', 'frank@test.com', '111-1116', '2020-01-06', 'J1', 55000.0, 0.1, 100, 20);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (7, 'Grace', 'Taylor', 'grace@test.com', '111-1117', '2020-01-07', 'J1', 56000.0, 0.1, 100, 21);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (8, 'Heidi', 'Anderson', 'heidi@test.com', '111-1118', '2020-01-08', 'J1', 57000.0, 0.1, 100, 30);
INSERT INTO Employees (employee_id, first_name, last_name, email, phone, hire_date, job_id, salary, commission_pct, manager_id, department_id) VALUES (9, 'Ivan', 'Thomas', 'ivan@test.com', '111-1119', '2020-01-09', 'J1', 58000.0, 0.1, 100, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT first_name FROM Employees WHERE department_id = 10 OR department_id = 20;

/*
Gold Result:
('Bob',)
('Frank',)
*/

-- Prediction Query
SELECT first_name FROM Employees WHERE department_id = 10 AND manager_id = 20;

/*
Prediction Result:
*/