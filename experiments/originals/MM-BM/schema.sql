-- Relational schema for ManyMutantsBM benchmark suite.
-- Universal schema compatible with SQLite, PostgreSQL, and MySQL.

CREATE TABLE departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    employee_id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dept_id INTEGER NOT NULL,
    title VARCHAR(50) NOT NULL,
    is_active INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE projects (
    project_id INTEGER PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL UNIQUE,
    dept_id INTEGER NOT NULL,
    budget REAL NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE assignments (
    assignment_id INTEGER PRIMARY KEY,
    employee_id INTEGER NOT NULL,
    project_id INTEGER NOT NULL,
    assigned_date VARCHAR(20) NOT NULL,
    hourly_rate REAL NOT NULL,
    UNIQUE (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE tasks (
    task_id INTEGER PRIMARY KEY,
    project_id INTEGER NOT NULL,
    assigned_to INTEGER,
    title VARCHAR(200) NOT NULL,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(20) NOT NULL,
    due_date VARCHAR(20) NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (assigned_to) REFERENCES employees(employee_id)
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    tier VARCHAR(20) NOT NULL,
    is_active INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date VARCHAR(20) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_priority VARCHAR(20) NOT NULL DEFAULT 'STANDARD',
    total_amount REAL NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    category_id INTEGER NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    list_price REAL NOT NULL,
    is_discontinued INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE order_items (
    item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price REAL NOT NULL,
    discount_rate REAL,
    UNIQUE (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE reviews (
    review_id INTEGER PRIMARY KEY,
    product_id INTEGER NOT NULL,
    customer_id INTEGER NOT NULL,
    rating INTEGER NOT NULL,
    is_verified INTEGER NOT NULL DEFAULT 0,
    review_date VARCHAR(20) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
