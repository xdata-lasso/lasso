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
-- Core logic test:
-- 1. Tests outer DISTINCT: Two different dates ('2023-01-01' and '2023-01-02') both yield a minimum count of 2.
-- 2. Tests MIN vs MAX/SUM/AVG: '2023-01-01' has job counts of 2 and 3 (MIN=2).
-- 3. Tests ORDER BY: '2023-01-03' is inserted first with a minimum count of 3, followed by dates with minimum count 2, ensuring unsorted insertion order.
-- 4. Tests grouping by job_title_code vs department_id/staff_id.
-- 5. Ensures actual department_id (101, 102) and staff_id (10..20) values are completely disjoint from the computed counts (2, 3) to catch column-name confusion mutants.
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (1, 'Chain A');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (1, 1, 'Store A', '123 St', '555-0001', 'store@a.com');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (101, 1, 'Sales');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (102, 1, 'HR');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (10, 'M', 'Staff 10');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (11, 'F', 'Staff 11');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (12, 'M', 'Staff 12');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (13, 'F', 'Staff 13');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (14, 'M', 'Staff 14');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (15, 'F', 'Staff 15');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (16, 'M', 'Staff 16');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (17, 'F', 'Staff 17');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (18, 'M', 'Staff 18');
INSERT INTO Staff (staff_id, staff_gender, staff_name) VALUES (19, 'F', 'Staff 19');
-- Date '2023-01-03': J4 has count 3 -> MIN(n) = 3
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (17, 101, '2023-01-03', 'J4', '2023-12-31');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (18, 101, '2023-01-03', 'J4', '2023-12-31');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (19, 102, '2023-01-03', 'J4', '2023-12-31');
-- Date '2023-01-01': J1 has count 2, J2 has count 3 -> MIN(n) = 2
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (10, 101, '2023-01-01', 'J1', '2023-06-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (11, 102, '2023-01-01', 'J1', '2023-06-02');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (12, 101, '2023-01-01', 'J2', '2023-06-03');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (13, 102, '2023-01-01', 'J2', '2023-06-04');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (14, 101, '2023-01-01', 'J2', '2023-06-05');
-- Date '2023-01-02': J3 has count 2 -> MIN(n) = 2 (Duplicates the MIN=2 from '2023-01-01' to test DISTINCT)
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (15, 101, '2023-01-02', 'J3', '2023-07-01');
INSERT INTO Staff_Department_Assignments (staff_id, department_id, date_assigned_from, job_title_code, date_assigned_to) VALUES (16, 102, '2023-01-02', 'J3', '2023-07-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT minn AS department_id FROM (SELECT date_assigned_from, MIN(n) AS minn FROM (SELECT date_assigned_from, job_title_code, COUNT(*) AS n FROM staff_department_assignments GROUP BY date_assigned_from, job_title_code) GROUP BY date_assigned_from) ORDER BY department_id;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT department_id FROM staff_department_assignments GROUP BY department_id ORDER BY COUNT(*), department_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(102,)
*/