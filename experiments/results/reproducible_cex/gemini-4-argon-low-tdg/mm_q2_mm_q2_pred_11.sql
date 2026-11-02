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
-- DATASET 2
-- Cardinality & Duplicates: tests EXISTS vs JOIN without DISTINCT (multiple active projects, multiple non-overdue tasks) and mixed task/project statuses.
INSERT INTO departments (dept_id, dept_name, location) VALUES (1, 'Engineering', 'SF');
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (201, 'Greg', 1, 'Senior Dev', 1);
INSERT INTO employees (employee_id, name, dept_id, title, is_active) VALUES (202, 'Hannah', 1, 'Lead Dev', 1);
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (30, 'Alpha', 1, 5000.0, 'ACTIVE');
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (40, 'Beta', 1, 6000.0, 'ACTIVE');
INSERT INTO projects (project_id, project_name, dept_id, budget, status) VALUES (50, 'Gamma', 1, 7000.0, 'COMPLETED');
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (10, 201, 30, '2023-03-01', 60.0);
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (11, 201, 40, '2023-03-02', 65.0);
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (12, 201, 50, '2023-03-03', 70.0);
INSERT INTO assignments (assignment_id, employee_id, project_id, assigned_date, hourly_rate) VALUES (13, 202, 30, '2023-03-01', 80.0);
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (2001, 30, 201, 'T1', 'LOW', 'COMPLETED', '2023-04-01');
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (2002, 40, 201, 'T2', 'HIGH', 'ACTIVE', '2023-04-02');
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (2003, 30, 202, 'T3', 'MEDIUM', 'COMPLETED', '2023-04-01');
INSERT INTO tasks (task_id, project_id, assigned_to, title, priority, status, due_date) VALUES (2004, 50, 202, 'T4', 'HIGH', 'OVERDUE', '2023-04-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE') AND EXISTS(SELECT 1 FROM assignments AS a JOIN projects AS p ON a.project_id = p.project_id WHERE a.employee_id = e.employee_id AND p.status = 'ACTIVE');

/*
Gold Result:
(201, 'Greg', 'Engineering')
*/

-- Prediction Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE' AND t.project_id IN (SELECT project_id FROM assignments WHERE employee_id = e.employee_id)) AND EXISTS(SELECT 1 FROM assignments AS a JOIN projects AS p ON a.project_id = p.project_id WHERE a.employee_id = e.employee_id AND p.status = 'ACTIVE');

/*
Prediction Result:
(201, 'Greg', 'Engineering')
(202, 'Hannah', 'Engineering')
*/