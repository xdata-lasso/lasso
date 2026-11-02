-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_details" TEXT(255));

CREATE TABLE "Staff" ("staff_id" INTEGER PRIMARY KEY, "staff_gender" TEXT(1), "staff_name" TEXT(80));

CREATE TABLE "Suppliers" ("supplier_id" INTEGER PRIMARY KEY, "supplier_name" TEXT(80), "supplier_phone" TEXT(80));

CREATE TABLE "Department_Store_Chain" ("dept_store_chain_id" INTEGER PRIMARY KEY, "dept_store_chain_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(10), "customer_code" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(10), "product_name" TEXT(80), "product_price" REAL(19, 4));

CREATE TABLE "Supplier_Addresses" ("supplier_id" INTEGER, "address_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, PRIMARY KEY ("supplier_id", "address_id"), FOREIGN KEY ("supplier_id") REFERENCES "Suppliers" ("supplier_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, PRIMARY KEY ("customer_id", "address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(10), "order_date" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Department_Stores" ("dept_store_id" INTEGER PRIMARY KEY, "dept_store_chain_id" INTEGER, "store_name" TEXT(80), "store_address" TEXT(255), "store_phone" TEXT(80), "store_email" TEXT(80), FOREIGN KEY ("dept_store_chain_id") REFERENCES "Department_Store_Chain" ("dept_store_chain_id"));

CREATE TABLE "Departments" ("department_id" INTEGER PRIMARY KEY, "dept_store_id" INTEGER, "department_name" TEXT(80), FOREIGN KEY ("dept_store_id") REFERENCES "Department_Stores" ("dept_store_id"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "product_id" INTEGER, "order_id" INTEGER, FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"));

CREATE TABLE "Product_Suppliers" ("product_id" INTEGER, "supplier_id" INTEGER, "date_supplied_from" DATETIME, "date_supplied_to" DATETIME, "total_amount_purchased" TEXT(80), "total_value_purchased" REAL(19, 4), PRIMARY KEY ("product_id", "supplier_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("supplier_id") REFERENCES "Suppliers" ("supplier_id"));

CREATE TABLE "Staff_Department_Assignments" ("staff_id" INTEGER, "department_id" INTEGER, "date_assigned_from" DATETIME, "job_title_code" TEXT(10), "date_assigned_to" DATETIME, PRIMARY KEY ("staff_id", "department_id"), FOREIGN KEY ("staff_id") REFERENCES "Staff" ("staff_id"), FOREIGN KEY ("department_id") REFERENCES "Departments" ("department_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (1, 'Chain A');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (1, 1, 'Store 1', '123 Main', '555-0001', 's1@test.com');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (10, 1, 'Sales');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (20, 1, 'HR');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (30, 1, 'IT');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (1, 'M', 'Zack');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (2, 'F', 'Alice');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (3, 'M', 'Bob');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (4, 'F', 'Charlie');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (1, 10, '2020-01-01', 'MGR', '2021-01-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (1, 20, '2021-01-02', 'MGR', NULL);
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (2, 10, '2019-01-01', 'DEV', '2020-01-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (2, 20, '2020-01-02', 'DEV', '2021-01-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (2, 30, '2021-01-02', 'LEAD', NULL);
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (3, 10, '2022-01-01', 'CLK', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT staff_name FROM (SELECT staff_id, staff_name, COUNT(*) AS n FROM (SELECT LHS.staff_id AS staff_id, LHS.staff_gender AS staff_gender, LHS.staff_name AS staff_name, RHS.department_id AS department_id, RHS.date_assigned_from AS date_assigned_from, RHS.job_title_code AS job_title_code, RHS.date_assigned_to AS date_assigned_to FROM staff AS LHS INNER JOIN staff_department_assignments AS RHS ON (LHS.staff_id = RHS.staff_id)) GROUP BY staff_id, staff_name) WHERE (n > 1) ORDER BY staff_name;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T1.staff_name FROM staff AS T1 JOIN staff_department_assignments AS T2 ON T1.staff_id = T2.staff_id GROUP BY T2.staff_id HAVING COUNT(*) > 1;

/*
Prediction Result:
('Zack',)
('Alice',)
*/