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
INSERT INTO categories (category_id, category_name, department) VALUES (1, 'default1', 'default1'), (10, 'default2', 'default1'), (-1, 'unique_2', 'default1'), (9, 'unique_3', 'default2'), (2, 'unique_4', 'default1'), (0, 'unique_5', 'default1'), (11, 'unique_6', 'default1'), (3, 'unique_7', 'default1'), (4, 'unique_8', 'default2'), (5, 'unique_9', 'default2'), (6, 'unique_10', 'default2'), (7, 'unique_11', 'default1'), (8, 'unique_12', 'default1'), (12, 'unique_13', 'default1'), (13, 'unique_14', 'default1'), (14, 'unique_15', 'default2'), (15, 'unique_16', 'default2'), (16, 'unique_17', 'default2'), (17, 'unique_18', 'default2'), (18, 'unique_19', 'default2'), (19, 'unique_20', 'default1');
INSERT INTO products (product_id, category_id, product_name, list_price, is_discontinued) VALUES (10, 12, 'default2', 2.0, -1), (-1, 13, 'default2', 9.0, -1), (1, -1, 'default2', 10.0, 2), (9, 12, 'default1', 10.0, 10), (0, 7, 'default2', 0.0, 1), (2, 19, 'default2', 9.0, 9), (11, 16, 'default1', 9.0, 10), (3, 19, 'default1', -1.0, 2), (4, 13, 'default1', 2.0, 9), (5, 16, 'default2', -1.0, 0), (6, 8, 'default1', 11.0, 1), (7, 0, 'default1', -1.0, 1), (8, 16, 'default2', -1.0, 0), (12, 8, 'default1', 0.0, 11), (13, 15, 'default1', 9.0, 10), (14, 7, 'default2', 1.0, 2), (15, 1, 'default1', 0.0, 10), (16, 12, 'default2', 1.0, 10), (17, 4, 'default1', 0.0, 1), (18, 16, 'default1', 1.0, 11), (19, 14, 'default2', 2.0, 1), (20, 16, 'default2', 1.0, 9), (21, 8, 'default1', 1.0, 10), (22, 14, 'default2', 0.0, 11), (23, 2, 'default1', 1.0, 2), (24, 15, 'default1', 0.0, 2), (25, 17, 'default1', 0.0, 10), (26, 5, 'default2', 1.0, -1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(5, 'default2', 16, -1.0)
*/

-- Prediction Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0 AND p.category_id <= 10) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
*/