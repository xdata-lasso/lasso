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
INSERT INTO categories (category_id, category_name, department) VALUES (2, 'default2', 'default2'), (100, 'default1', 'default1'), (99, 'unique_2', 'default2'), (-1, 'unique_3', 'default2'), (1, 'unique_4', 'default2'), (0, 'unique_5', 'default1'), (101, 'unique_6', 'default2'), (3, 'unique_7', 'default1'), (4, 'unique_8', 'default2'), (5, 'unique_9', 'default2'), (6, 'unique_10', 'default2'), (7, 'unique_11', 'default2'), (8, 'unique_12', 'default1'), (9, 'unique_13', 'default2'), (10, 'unique_14', 'default1'), (11, 'unique_15', 'default1'), (12, 'unique_16', 'default1'), (13, 'unique_17', 'default1'), (14, 'unique_18', 'default1'), (15, 'unique_19', 'default2'), (16, 'unique_20', 'default1'), (17, 'unique_21', 'default1'), (18, 'unique_22', 'default1'), (19, 'unique_23', 'default1'), (20, 'unique_24', 'default2'), (21, 'unique_25', 'default2'), (22, 'unique_26', 'default2'), (23, 'unique_27', 'default1'), (24, 'unique_28', 'default2'), (25, 'unique_29', 'default1'), (26, 'unique_30', 'default1');
INSERT INTO products (product_id, category_id, product_name, list_price, is_discontinued) VALUES (1, 101, 'default1', 0.0, 2), (100, 26, 'default1', 1.0, 99), (2, 18, 'default2', 2.0, 99), (-1, 23, 'default2', 1.0, -1), (0, 5, 'default1', -1.0, -1), (99, 24, 'default2', 100.0, 101), (101, 25, 'default2', 2.0, 0), (3, 16, 'default1', 1.0, 100), (4, 14, 'default2', 100.0, 2), (5, 18, 'default1', 99.0, 2), (6, 99, 'default1', 100.0, 99), (7, 14, 'default1', 1.0, -1), (8, 11, 'default1', 100.0, 0), (9, 26, 'default1', -1.0, -1), (10, -1, 'default1', 2.0, 100), (11, 24, 'default1', 0.0, 99), (12, 8, 'default2', 101.0, 99), (13, 16, 'default2', 99.0, 99), (14, 100, 'default2', 2.0, 99), (15, 6, 'default2', 2.0, 100), (16, 101, 'default2', 1.0, 101), (17, 20, 'default2', 0.0, -1), (18, 4, 'default1', 99.0, 100), (19, 99, 'default1', 0.0, 101), (20, 8, 'default1', 2.0, 100), (21, 9, 'default1', -1.0, 1), (22, 10, 'default1', 2.0, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(8, 'default1', 11, 100.0)
(101, 'default2', 25, 2.0)
*/

-- Prediction Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0 AND p.product_id <= 100) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(8, 'default1', 11, 100.0)
*/