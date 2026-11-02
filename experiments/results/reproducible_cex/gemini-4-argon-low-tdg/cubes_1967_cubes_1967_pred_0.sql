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
-- Tests standard multiple distinct job_title_codes, duplicate job_title_codes (INTERSECT deduplication vs UNION ALL/direct table scan), and outer DISTINCT on counts.
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (1, 'M', 'Alice');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (2, 'F', 'Bob');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (3, 'M', 'Charlie');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (1, 'Chain A');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (1, 1, 'Store 1', 'Addr 1', '111', 'a@b.com');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (10, 1, 'Dept 10');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (20, 1, 'Dept 20');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (30, 1, 'Dept 30');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (1, 10, '2020-01-01', 'MGR', '2021-01-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (2, 20, '2020-01-01', 'MGR', '2021-01-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (3, 30, '2020-01-01', 'CLK', '2021-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS department_id FROM (SELECT job_title_code, COUNT(*) AS n FROM (SELECT job_title_code FROM staff_department_assignments INTERSECT SELECT job_title_code FROM staff_department_assignments) GROUP BY job_title_code) ORDER BY department_id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT department_id FROM staff_department_assignments GROUP BY department_id ORDER BY COUNT(*), department_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/