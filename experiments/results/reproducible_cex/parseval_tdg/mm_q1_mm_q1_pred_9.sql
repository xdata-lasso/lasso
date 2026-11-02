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
INSERT INTO "customers" VALUES(1,'c_s_053686','cus_cbd3eb',1);
INSERT INTO "customers" VALUES(2,'cus_8c18e3','cus_cbd3eb',-55602865);
INSERT INTO "customers" VALUES(3,'c_s_053686','cus_cbd3eb',1);
INSERT INTO "customers" VALUES(4,'cus_8c18e3','cus_cbd3eb',-59984348);
INSERT INTO "customers" VALUES(5,'cus_8c18e3','cus_cbd3eb',-1022641847);
INSERT INTO "customers" VALUES(6,'cus_8c18e3','cus_cbd3eb',247012447);
INSERT INTO "customers" VALUES(7,'cus_8c18e3','cus_cbd3eb',-1980249628);
INSERT INTO "customers" VALUES(8,'cus_8c18e3','cus_cbd3eb',-734455130);
INSERT INTO "customers" VALUES(9,'cus_8c18e3','cus_cbd3eb',-1633151678);
INSERT INTO "customers" VALUES(10,'cus_8c18e3','cus_cbd3eb',-252690330);
INSERT INTO "customers" VALUES(11,'cus_8c18e3','cus_cbd3eb',1115440883);
INSERT INTO "customers" VALUES(12,'cus_8c18e3','cus_cbd3eb',1465859724);
INSERT INTO "customers" VALUES(13,'cus_8c18e3','cus_cbd3eb',-1349201381);
INSERT INTO "orders" VALUES(-2147483647,1,'ord_9b8b62','o_s_60a1f2','ord_ea6ccd',1.0);
INSERT INTO "orders" VALUES(-2147483646,1,'ord_9b8b62','o_s_60a1f2','ord_ea6ccd',1.0);
INSERT INTO "orders" VALUES(-2147483645,1,'ord_9b8b62','o_s_60a1f2','ord_ea6ccd',1.0);
INSERT INTO "orders" VALUES(-2147483644,1,'ord_9b8b62','o_s_60a1f2','ord_ea6ccd',1.0);
INSERT INTO "orders" VALUES(1,1,'ord_9b8b62','o_s_2622b3','ord_ea6ccd',1.0);
INSERT INTO "orders" VALUES(2,4,'ord_9b8b62','ord_04c53a','ord_ea6ccd',345.329712);
INSERT INTO "orders" VALUES(3,5,'ord_9b8b62','ord_04c53a','ord_ea6ccd',97.952323);
INSERT INTO "orders" VALUES(4,6,'ord_9b8b62','ord_04c53a','ord_ea6ccd',868.436572);
INSERT INTO "orders" VALUES(5,7,'ord_9b8b62','ord_04c53a','ord_ea6ccd',249.706432);
INSERT INTO "orders" VALUES(6,8,'ord_9b8b62','ord_04c53a','ord_ea6ccd',906.21648);
INSERT INTO "orders" VALUES(7,9,'ord_9b8b62','ord_04c53a','ord_ea6ccd',134.487977);
INSERT INTO "orders" VALUES(8,10,'ord_9b8b62','ord_04c53a','ord_ea6ccd',797.015047);
INSERT INTO "orders" VALUES(9,11,'ord_9b8b62','ord_04c53a','ord_ea6ccd',882.963176);
INSERT INTO "orders" VALUES(10,12,'ord_9b8b62','ord_04c53a','ord_ea6ccd',294.861575);
INSERT INTO "orders" VALUES(11,13,'ord_9b8b62','ord_04c53a','ord_ea6ccd',737.440743);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.total_amount), 0.0) AS total_spend FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id AND o.order_status = 'COMPLETED' WHERE c.is_active = 1 GROUP BY c.customer_id, c.customer_name;

-- Prediction Query
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS total_orders, COALESCE(SUM(o.total_amount), 0.0) AS total_spend FROM customers AS c LEFT JOIN orders AS o ON c.customer_id = o.customer_id AND o.order_status = 'COMPLETED' GROUP BY c.customer_id, c.customer_name;