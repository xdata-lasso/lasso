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
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1, 'CC', 'CUST001', 'Charlie', '123 Maple St', '555-0101', 'charlie@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (2, 'PP', 'CUST002', 'Alice', '456 Oak Ave', '555-0102', 'alice@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (3, 'DB', 'CUST003', 'Bob', '789 Pine Rd', '555-0103', 'bob@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (4, 'CC', 'CUST004', 'David', '101 Elm St', '555-0104', 'david@example.com');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (101, 1, 'Pending', '2023-01-15 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (102, 2, 'Pending', '2023-01-16 11:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (103, 3, 'Shipped', '2023-01-17 12:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."order_id" AS "order_id", "LHS"."customer_id" AS "customer_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "RHS"."payment_method_code" AS "payment_method_code", "RHS"."customer_code" AS "customer_code", "RHS"."customer_name" AS "customer_name", "RHS"."customer_address" AS "customer_address", "RHS"."customer_phone" AS "customer_phone", "RHS"."customer_email" AS "customer_email" FROM (SELECT * FROM "customer_orders" WHERE ("order_status_code" = 'Pending')) AS LHS INNER JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Charlie',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status_code = 'Pending' ORDER BY T2.customer_id, T1.customer_name NULLS LAST;

/*
Prediction Result:
('Charlie',)
('Alice',)
*/