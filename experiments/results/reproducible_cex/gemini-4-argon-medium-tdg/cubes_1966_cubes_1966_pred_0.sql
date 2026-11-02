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
-- Tests exact boundaries (600.0 and 700.0), values outside the range, NULL prices, and ORDER BY product_name ASC with tie-breaking on product_id ASC.
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1, 'Cloth', 'Jacket', 600.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (2, 'Cloth', 'Coat', 600.0001);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (3, 'Elec', 'Monitor', 699.9999);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (4, 'Elec', 'TV', 700.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (5, 'Cloth', 'Shirt', 500.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (6, 'Elec', 'Laptop', 800.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (7, 'Misc', 'Unknown', NULL);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (10, 'Elec', 'Camera', 650.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (8, 'Elec', 'Camera', 650.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_name, product_id FROM products WHERE (product_price > 600.0 AND product_price < 700.0) ORDER BY product_name, products.product_id NULLS LAST;

/*
Gold Result:
('Camera', 8)
('Camera', 10)
('Coat', 2)
('Monitor', 3)
*/

-- Prediction Query
SELECT product_name, product_id FROM products WHERE product_price BETWEEN 600 AND 700;

/*
Prediction Result:
('Jacket', 1)
('Coat', 2)
('Monitor', 3)
('TV', 4)
('Camera', 8)
('Camera', 10)
*/