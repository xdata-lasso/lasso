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
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (20, 'Clothes29');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (19, 'Clothes29');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (22, 'Clothes29', 'Clothes29');
INSERT INTO "Staff" ("staff_id", "staff_gender", "staff_name") VALUES (21, 'Clothes29', 'Clothes29');
INSERT INTO "Suppliers" ("supplier_id", "supplier_name", "supplier_phone") VALUES (24, 'Clothes29', 'Clothes29');
INSERT INTO "Suppliers" ("supplier_id", "supplier_name", "supplier_phone") VALUES (23, 'Clothes29', 'Clothes29');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (26, 'Clothes29');
INSERT INTO "Department_Store_Chain" ("dept_store_chain_id", "dept_store_chain_name") VALUES (25, 'Clothes29');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (28, 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (27, 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (30, NULL, 'Clothes29', NULL);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (29, NULL, 'Clothes29', 9294);
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_from", "date_to") VALUES (28, 19, 29, 29);
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_from", "date_to") VALUES (27, 20, 29, 29);
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (33, 27, 'Clothes29', 29);
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (32, 27, 'Clothes29', 29);
INSERT INTO "Department_Stores" ("dept_store_id", "dept_store_chain_id", "store_name", "store_address", "store_phone", "store_email") VALUES (34, 25, 'Clothes29', 'Clothes29', 'Clothes29', 'Clothes29');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (37, 34, 'Clothes29');
INSERT INTO "Departments" ("department_id", "dept_store_id", "department_name") VALUES (36, NULL, 'Clothes29');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (39, 29, 32);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (38, 29, 32);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (29, 24, 29, 29, 'Clothes29', 29);
INSERT INTO "Product_Suppliers" ("product_id", "supplier_id", "date_supplied_from", "date_supplied_to", "total_amount_purchased", "total_value_purchased") VALUES (29, 23, 29, 29, 'Clothes29', 29);
INSERT INTO "Staff_Department_Assignments" ("staff_id", "department_id", "date_assigned_from", "job_title_code", "date_assigned_to") VALUES (21, 36, 29, 'Clothes29', 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanproduct_price" AS "avg_product_price_" FROM (SELECT "product_type_code", AVG("product_price") AS "meanproduct_price" FROM "products" GROUP BY "product_type_code") WHERE ("product_type_code" = 'Clothes') ORDER BY avg_product_price_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(product_price) FROM products WHERE product_type_code = 'Clothes';

/*
Prediction Result:
(None,)
*/