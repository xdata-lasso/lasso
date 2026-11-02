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
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (10, 'Chain Alpha');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (20, 'Chain Beta');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (30, 'Chain Gamma');
INSERT INTO Department_Store_Chain (dept_store_chain_id, dept_store_chain_name) VALUES (40, 'Chain Delta');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (1, 10, 'B_Store', '300 Beta St', '400-0000', 'c@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (2, 20, 'A_Store', '900 Zebra Ave', '300-0000', 'b@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (3, 40, 'C_Store', '100 Alpha Rd', '200-0000', 'd@store.com');
INSERT INTO Department_Stores (dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email) VALUES (4, 30, 'D_Store', '700 Yak Blvd', '100-0000', 'a@store.com');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (101, 2, 'Electronics');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (102, 2, 'Apparel');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (103, 2, 'Home Goods');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (104, 1, 'Groceries');
INSERT INTO Departments (department_id, dept_store_id, department_name) VALUES (105, 3, 'Toys');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT dept_store_id AS dept_store_chain_id FROM (SELECT * FROM (SELECT * FROM (SELECT dept_store_id, dept_store_chain_id, store_name, store_address, store_phone, store_email, COUNT(*) OVER () AS n FROM department_stores) ORDER BY store_address DESC) LIMIT 2);

/*
Gold Result:
(2,)
(4,)
*/

-- Prediction Query
SELECT dept_store_chain_id FROM department_stores GROUP BY dept_store_chain_id ORDER BY COUNT(*) DESC, dept_store_chain_id NULLS LAST LIMIT 2;

/*
Prediction Result:
(10,)
(20,)
*/