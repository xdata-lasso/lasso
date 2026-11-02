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
INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (28, 'COMPLETED24', 'COMPLETED39');
INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (27, 'COMPLETED23', 'COMPLETED39');
INSERT INTO "employees" ("employee_id", "dept_id", "name", "title", "is_active") VALUES (30, 27, 'COMPLETED39', 'COMPLETED39', 39);
INSERT INTO "employees" ("employee_id", "dept_id", "name", "title", "is_active") VALUES (29, 28, 'COMPLETED39', 'COMPLETED39', 39);
INSERT INTO "projects" ("project_id", "dept_id", "project_name", "budget", "status") VALUES (32, 28, 'COMPLETED26', 39, 'COMPLETED39');
INSERT INTO "projects" ("project_id", "dept_id", "project_name", "budget", "status") VALUES (31, 27, 'COMPLETED25', 39, 'COMPLETED39');
INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (33, 29, 32, 'COMPLETED39', 39);
INSERT INTO "tasks" ("task_id", "project_id", "assigned_to", "title", "priority", "status", "due_date") VALUES (36, 32, 30, 'COMPLETED39', 'COMPLETED39', 'COMPLETED39', 'COMPLETED39');
INSERT INTO "tasks" ("task_id", "project_id", "assigned_to", "title", "priority", "status", "due_date") VALUES (35, 31, 29, 'COMPLETED39', 'COMPLETED39', 'COMPLETED39', 'COMPLETED39');
INSERT INTO "customers" ("customer_id", "customer_name", "tier", "is_active") VALUES (39, 'COMPLETED74', 'COMPLETED48', 1);
INSERT INTO "customers" ("customer_id", "customer_name", "tier", "is_active") VALUES (37, 'COMPLETED51', 'COMPLETED52', 1);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "order_priority", "total_amount") VALUES (38, 39, 'COMPLETED49', 'COMPLETED', 'COMPLETED50', 0);
INSERT INTO "orders" ("order_id", "customer_id", "order_date", "order_status", "order_priority", "total_amount") VALUES (71, 39, 'COMPLETED72', 'COMPLETED', 'COMPLETED73', 1);
INSERT INTO "categories" ("category_id", "category_name", "department") VALUES (41, 'COMPLETED39', 'COMPLETED39');
INSERT INTO "products" ("product_id", "category_id", "product_name", "list_price", "is_discontinued") VALUES (43, 41, 'COMPLETED39', 39, 39);
INSERT INTO "products" ("product_id", "category_id", "product_name", "list_price", "is_discontinued") VALUES (42, 41, 'COMPLETED39', 39, 39);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.total_amount), 0.0) AS total_spend FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id AND o.order_status = 'COMPLETED' WHERE c.is_active = 1 GROUP BY c.customer_id, c.customer_name;

/*
Gold Result:
(37, 'COMPLETED51', 0, 0.0)
(39, 'COMPLETED74', 2, 1.0)
*/

-- Prediction Query
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders, COALESCE(MIN(o.total_amount), 0.0) AS total_spend FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id AND o.order_status = 'COMPLETED' WHERE c.is_active = 1 GROUP BY c.customer_id, c.customer_name;

/*
Prediction Result:
(37, 'COMPLETED51', 0, 0.0)
(39, 'COMPLETED74', 2, 0.0)
*/