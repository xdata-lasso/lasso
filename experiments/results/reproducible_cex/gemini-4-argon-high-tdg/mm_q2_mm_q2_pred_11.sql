-- Schema DDL
/* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE departments (dept_id INTEGER PRIMARY KEY, dept_name TEXT(100) NOT NULL UNIQUE, location TEXT(100) NOT NULL);

CREATE TABLE employees (employee_id INTEGER PRIMARY KEY, name TEXT(100) NOT NULL, dept_id INTEGER NOT NULL, title TEXT(50) NOT NULL, is_active INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

CREATE TABLE projects (project_id INTEGER PRIMARY KEY, project_name TEXT(100) NOT NULL UNIQUE, dept_id INTEGER NOT NULL, budget REAL NOT NULL, status TEXT(20) NOT NULL, FOREIGN KEY (dept_id) REFERENCES departments (dept_id));

CREATE TABLE assignments (assignment_id INTEGER PRIMARY KEY, employee_id INTEGER NOT NULL, project_id INTEGER NOT NULL, assigned_date TEXT(20) NOT NULL, hourly_rate REAL NOT NULL, UNIQUE (employee_id, project_id), FOREIGN KEY (employee_id) REFERENCES employees (employee_id), FOREIGN KEY (project_id) REFERENCES projects (project_id));

CREATE TABLE tasks (task_id INTEGER PRIMARY KEY, project_id INTEGER NOT NULL, assigned_to INTEGER, title TEXT(200) NOT NULL, priority TEXT(20) NOT NULL, status TEXT(20) NOT NULL, due_date TEXT(20) NOT NULL, FOREIGN KEY (project_id) REFERENCES projects (project_id), FOREIGN KEY (assigned_to) REFERENCES employees (employee_id));

CREATE TABLE customers (customer_id INTEGER PRIMARY KEY, customer_name TEXT(100) NOT NULL, tier TEXT(20) NOT NULL, is_active INTEGER NOT NULL DEFAULT 1);

CREATE TABLE orders (order_id INTEGER PRIMARY KEY, customer_id INTEGER NOT NULL, order_date TEXT(20) NOT NULL, order_status TEXT(20) NOT NULL, order_priority TEXT(20) NOT NULL DEFAULT 'STANDARD', total_amount REAL NOT NULL DEFAULT 0, FOREIGN KEY (customer_id) REFERENCES customers (customer_id));

CREATE TABLE categories (category_id INTEGER PRIMARY KEY, category_name TEXT(100) NOT NULL UNIQUE, department TEXT(50) NOT NULL);

CREATE TABLE products (product_id INTEGER PRIMARY KEY, category_id INTEGER NOT NULL, product_name TEXT(100) NOT NULL, list_price REAL NOT NULL, is_discontinued INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (category_id) REFERENCES categories (category_id));

CREATE TABLE order_items (item_id INTEGER PRIMARY KEY, order_id INTEGER NOT NULL, product_id INTEGER NOT NULL, quantity INTEGER NOT NULL, unit_price REAL NOT NULL, discount_rate REAL, UNIQUE (order_id, product_id), FOREIGN KEY (order_id) REFERENCES orders (order_id), FOREIGN KEY (product_id) REFERENCES products (product_id));

CREATE TABLE reviews (review_id INTEGER PRIMARY KEY, product_id INTEGER NOT NULL, customer_id INTEGER NOT NULL, rating INTEGER NOT NULL, is_verified INTEGER NOT NULL DEFAULT 0, review_date TEXT(20) NOT NULL, FOREIGN KEY (product_id) REFERENCES products (product_id), FOREIGN KEY (customer_id) REFERENCES customers (customer_id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO departments (dept_id, dept_name, location) VALUES (10, 'Engineering', 'Boston');
INSERT INTO departments (dept_id, dept_name, location) VALUES (20, 'Marketing', 'Boston');
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (101, 'Quinn Stevens', 10, 'Embedded Engineer', 1);
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (102, 'Rachel Turner', 20, 'Growth Engineer', 1);
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (103, 'Sam Underwood', 10, 'Firmware Engineer', 1);
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (104, 'Tina Vance', 10, 'Verification Engineer', 1);
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (201, 'AdTech Portal', 20, 100000.0, 'ACTIVE');
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (202, 'Kernel Upgrade', 10, 200000.0, 'ACTIVE');
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (203, 'Legacy Driver', 10, 50000.0, 'ARCHIVED');
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (301, 101, 201, '2025-02-01', 98.0);
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (302, 102, 202, '2025-02-02', 88.0);
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (303, 103, 202, '2025-02-03', 102.0);
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (401, 203, 103, 'Decommission old driver', 'LOW', 'OVERDUE', '2024-12-31');
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (402, 202, 104, 'Review kernel patch', 'HIGH', 'COMPLETED', '2025-02-15');
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (403, 201, 102, 'Launch campaign', 'HIGH', 'OVERDUE', '2025-02-10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE') AND EXISTS(SELECT 1 FROM assignments AS a JOIN projects AS p ON a.project_id = p.project_id WHERE a.employee_id = e.employee_id AND p.status = 'ACTIVE');

/*
Gold Result:
(101, 'Quinn Stevens', 'Engineering')
*/

-- Prediction Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE' AND t.project_id IN (SELECT project_id FROM assignments WHERE employee_id = e.employee_id)) AND EXISTS(SELECT 1 FROM assignments AS a JOIN projects AS p ON a.project_id = p.project_id WHERE a.employee_id = e.employee_id AND p.status = 'ACTIVE');

/*
Prediction Result:
(101, 'Quinn Stevens', 'Engineering')
(103, 'Sam Underwood', 'Engineering')
*/