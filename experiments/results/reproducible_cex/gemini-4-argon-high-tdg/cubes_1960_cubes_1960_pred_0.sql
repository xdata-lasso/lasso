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
INSERT INTO Addresses (address_id, address_details) VALUES (1, 'Middle Rd');
INSERT INTO Addresses (address_id, address_details) VALUES (2, 'Zebra St');
INSERT INTO Addresses (address_id, address_details) VALUES (3, 'Alpha Ave');
INSERT INTO Addresses (address_id, address_details) VALUES (10, 'Address ID Ten St');
INSERT INTO Addresses (address_id, address_details) VALUES (50, 'Supplier Ten Blvd');
INSERT INTO Addresses (address_id, address_details) VALUES (99, 'Unassigned Way');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (9, 'CARD', 'C09', 'Customer Nine', '9 Inline Address', '111-1111', 'c9@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (10, 'CASH', 'C10', 'Customer Ten', '10 Inline Customer Table Address', '222-2222', 'c10@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (11, 'CARD', 'C11', 'Customer Eleven', '11 Inline Address', '333-3333', 'c11@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (100, 'CASH', 'C100', 'Customer Hundred', '100 Inline Address', '444-4444', 'c100@example.com');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (10, 1, '2020-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (10, 2, '2018-01-01 00:00:00', '2021-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (10, 3, '2019-01-01 00:00:00', '2022-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (9, 10, '2020-05-01 00:00:00', '2021-05-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (11, 10, '2021-06-01 00:00:00', '2022-06-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_from, date_to) VALUES (100, 1, '2022-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO Suppliers (supplier_id, supplier_name, supplier_phone) VALUES (10, 'Supplier Ten', '999-9999');
INSERT INTO Supplier_Addresses (supplier_id, address_id, date_from, date_to) VALUES (10, 50, '2015-01-01 00:00:00', '2025-01-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT address_details FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.customer_id AS customer_id, RHS.date_from AS date_from, RHS.date_to AS date_to FROM addresses AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.address_id = RHS.address_id)) WHERE (customer_id = 10) ORDER BY address_details;

/*
Gold Result:
('Alpha Ave',)
('Middle Rd',)
('Zebra St',)
*/

-- Prediction Query
SELECT T1.address_details FROM addresses AS T1 JOIN customer_addresses AS T2 ON T1.address_id = T2.address_id WHERE T2.customer_id = 10;

/*
Prediction Result:
('Middle Rd',)
('Zebra St',)
('Alpha Ave',)
*/