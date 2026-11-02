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
-- Inserting into table: departments --
INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (1, 'Engineering', 'dep_af7416');

INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (2, 'dept_name_2', 'dep_af7416');

INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (3, 'A', 'dep_af7416');

INSERT INTO "departments" ("dept_id", "dept_name", "location") VALUES (4, 'D', 'dep_af7416');

-- Inserting into table: employees --
INSERT INTO "employees" ("employee_id", "name", "dept_id", "title", "is_active") VALUES (1, 'e_s_4c35e1', 1, 'emp_567e9d', 1);

INSERT INTO "employees" ("employee_id", "name", "dept_id", "title", "is_active") VALUES (2, 'e_s_4c35e1', 1, 'emp_567e9d', 1);

INSERT INTO "employees" ("employee_id", "name", "dept_id", "title", "is_active") VALUES (3, 'e_s_9a3557', 1, 'emp_567e9d', 1);

INSERT INTO "employees" ("employee_id", "name", "dept_id", "title", "is_active") VALUES (4, 'emp_d2c0f7', 3, 'emp_567e9d', 1);

INSERT INTO "employees" ("employee_id", "name", "dept_id", "title", "is_active") VALUES (5, 'emp_d2c0f7', 4, 'emp_567e9d', 2);

-- Inserting into table: projects --
INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483648, 'project_name_1', 1, 165.344793, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483647, 'project_name_2', 2, 38.668834, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483646, 'project_name_3', 1, 475.173408, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483645, 'project_name_4', 2, 520.784135, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483644, 'project_name_5', 2, 134.487977, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483643, 'project_name_6', 2, 378.476082, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483642, 'project_name_7', 1, 294.861575, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483641, 'project_name_8', 1, 994.117864, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483640, 'project_name_9', 2, 737.440743, 'pro_5ea102');

INSERT INTO "projects" ("project_id", "project_name", "dept_id", "budget", "status") VALUES (-2147483639, 'project_name_10', 1, 303.05704, 'pro_5ea102');

-- Inserting into table: assignments --
INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483648, 1, -2147483648, 'ass_5ada04', 285.529132);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483647, 1, -2147483647, 'ass_5ada04', 292.730571);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483646, 1, -2147483646, 'ass_5ada04', 935.695299);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483645, 1, -2147483645, 'ass_5ada04', 86.520366);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483644, 3, -2147483648, 'ass_5ada04', 483.665643);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483643, 3, -2147483644, 'ass_5ada04', 941.961117);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483642, 3, -2147483643, 'ass_5ada04', 783.93201);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483641, 1, -2147483643, 'ass_5ada04', 759.708817);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483640, 1, -2147483642, 'ass_5ada04', 268.234631);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483639, 1, -2147483641, 'ass_5ada04', 749.826493);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483638, 1, -2147483640, 'ass_5ada04', 334.878198);

INSERT INTO "assignments" ("assignment_id", "employee_id", "project_id", "assigned_date", "hourly_rate") VALUES (-2147483637, 1, -2147483639, 'ass_5ada04', 125.12763);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE') AND EXISTS(SELECT 1 FROM assignments AS a JOIN projects AS p ON a.project_id = p.project_id WHERE a.employee_id = e.employee_id AND p.status = 'ACTIVE');

/*
Gold Result:
*/

-- Prediction Query
SELECT e.employee_id, e.name, d.dept_name FROM employees AS e JOIN departments AS d ON e.dept_id = d.dept_id WHERE e.is_active = 1 AND d.dept_name = 'Engineering' AND NOT EXISTS(SELECT 1 FROM tasks AS t WHERE t.assigned_to = e.employee_id AND t.status = 'OVERDUE') AND EXISTS(SELECT 1 FROM assignments AS a WHERE a.employee_id = e.employee_id);

/*
Prediction Result:
(1, 'e_s_4c35e1', 'Engineering')
(3, 'e_s_9a3557', 'Engineering')
*/