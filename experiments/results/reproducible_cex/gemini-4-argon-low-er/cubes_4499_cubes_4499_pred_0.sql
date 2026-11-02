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
INSERT INTO Addresses (address_id, address_details) VALUES (1, 'B_Address');
INSERT INTO Addresses (address_id, address_details) VALUES (2, 'A_Address');
INSERT INTO Suppliers (supplier_id, supplier_name, supplier_phone) VALUES (1, 'Alpha', '111');
INSERT INTO Suppliers (supplier_id, supplier_name, supplier_phone) VALUES (2, 'Beta', '222');
INSERT INTO Supplier_Addresses (supplier_id, address_id, date_from, date_to) VALUES (1, 1, '2020-01-01', '2020-12-31');
INSERT INTO Supplier_Addresses (supplier_id, address_id, date_from, date_to) VALUES (2, 2, '2020-01-01', '2020-12-31');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT supplier_name, supplier_phone FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, LHS.supplier_id AS supplier_id, LHS.supplier_name AS supplier_name, LHS.supplier_phone AS supplier_phone, RHS.date_from AS date_from, RHS.date_to AS date_to FROM (SELECT LHS.address_id AS address_id, LHS.address_details AS address_details, RHS.supplier_id AS supplier_id, RHS.supplier_name AS supplier_name, RHS.supplier_phone AS supplier_phone FROM addresses AS LHS CROSS JOIN suppliers AS RHS) AS LHS INNER JOIN supplier_addresses AS RHS ON (LHS.address_id = RHS.address_id AND LHS.supplier_id = RHS.supplier_id)) ORDER BY supplier_name, supplier_phone NULLS LAST;

/*
Gold Result:
('Alpha', '111')
('Beta', '222')
*/

-- Prediction Query
SELECT T1.supplier_name, T1.supplier_phone FROM Suppliers AS T1 JOIN supplier_addresses AS T2 ON T1.supplier_id = T2.supplier_id JOIN addresses AS T3 ON T2.address_id = T3.address_id ORDER BY T3.address_details, T1.supplier_id NULLS LAST, T2.supplier_id NULLS LAST, T2.address_id NULLS LAST, T3.address_id NULLS LAST;

/*
Prediction Result:
('Beta', '222')
('Alpha', '111')
*/