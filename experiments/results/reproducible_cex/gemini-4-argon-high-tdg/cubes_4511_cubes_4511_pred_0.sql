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
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (1, 'Chain One');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (2, 'Chain Two');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (3, 'Chain Three');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (10, 'Chain Ten');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (20, 'Chain Twenty');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (30, 'Chain Thirty');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (40, 'Chain Forty');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (50, 'Chain Fifty Empty');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (10, 3, 'Store Ten', '900 Zebra Rd', '555-0010', 'z10@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (30, 2, 'Store Thirty', '100 Alpha Ave', '555-0030', 'a30@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (20, 1, 'Store Twenty Mismatch Count', '200 Beta St', '555-0020', 'b20@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (99, 1, 'Store NinetyNine Mismatch ID', '300 Gamma St', '555-0099', 'g99@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (101, 10, 'C10 S1', '101 Main', '555-0101', 's101@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (102, 10, 'C10 S2', '102 Main', '555-0102', 's102@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (103, 10, 'C10 S3', '103 Main', '555-0103', 's103@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (301, 30, 'C30 S1', '301 Oak', '555-0301', 's301@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (302, 30, 'C30 S2', '302 Oak', '555-0302', 's302@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (201, 20, 'C20 S1', '201 Pine', '555-0201', 's201@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (202, 20, 'C20 S2', '202 Pine', '555-0202', 's202@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (203, 20, 'C20 S3', '203 Pine', '555-0203', 's203@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (204, 20, 'C20 S4', '204 Pine', '555-0204', 's204@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (401, 40, 'C40 S1', '401 Elm', '555-0401', 's401@store.com');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (1, 10, 'Electronics');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (2, 10, 'Apparel');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (3, 101, 'Home');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS dept_store_chain_id FROM (SELECT dept_store_chain_id, n, store_name, store_address, store_phone, store_email, dept_store_chain_id AS dept_store_id FROM (SELECT LHS.dept_store_chain_id AS dept_store_chain_id, LHS.n AS n, RHS.store_name AS store_name, RHS.store_address AS store_address, RHS.store_phone AS store_phone, RHS.store_email AS store_email FROM (SELECT dept_store_chain_id, COUNT(*) AS n FROM department_stores GROUP BY dept_store_chain_id) AS LHS INNER JOIN department_stores AS RHS ON (LHS.dept_store_chain_id = RHS.dept_store_id AND LHS.n = RHS.dept_store_chain_id))) ORDER BY dept_store_chain_id;

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT dept_store_chain_id FROM department_stores GROUP BY dept_store_chain_id ORDER BY COUNT(*) DESC, dept_store_chain_id NULLS LAST LIMIT 2;

/*
Prediction Result:
(20,)
(10,)
*/