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
INSERT INTO categories (category_id, category_name, department) VALUES (6, 'default1', 'default1'), (4, 'default2', 'default1'), (5, 'unique_2', 'default2'), (1, 'unique_3', 'default2'), (0, 'unique_4', 'default1'), (-1, 'unique_5', 'default2'), (2, 'unique_6', 'default2');
INSERT INTO products (product_id, category_id, product_name, list_price, is_discontinued) VALUES (-1, 0, 'default2', 2.0, 4), (0, 4, 'default2', 0.0, 0), (5, 4, 'default1', 2.0, 4), (1, 6, 'default2', 0.0, 6), (6, 6, 'default1', 1.0, 5), (2, 5, 'default2', 0.0, 4), (4, 6, 'default1', 5.0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Gold Result:
(0, 'default2', 4, 0.0)
(4, 'default1', 6, 5.0)
*/

-- Prediction Query
SELECT product_id, product_name, category_id, list_price FROM (SELECT p.product_id, p.product_name, p.category_id, p.list_price, ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY p.list_price DESC, p.product_id ASC) AS rank_in_cat FROM products AS p WHERE p.is_discontinued = 0 AND p.category_id <= 5) AS ranked WHERE ranked.rank_in_cat = 1;

/*
Prediction Result:
(0, 'default2', 4, 0.0)
*/