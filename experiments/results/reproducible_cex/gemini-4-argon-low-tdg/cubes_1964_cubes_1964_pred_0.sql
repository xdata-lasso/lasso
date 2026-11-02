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
-- Tests:
-- 1. DISTINCT on customer_name (multiple orders of 'keyboard' by the same customer, and two different customers with the same name).
-- 2. ORDER BY customer_name ASC NULLS LAST (multiple customer names out of alphabetical order, plus a customer with NULL customer_name).
-- 3. Filtering on product_name = 'keyboard' vs 'Keyboard' (case-sensitivity), 'wireless keyboard' (LIKE vs =), and 'mouse'.
-- 4. INNER JOIN semantics (customers with no orders, orders with no items, products never ordered).
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1, 'CARD', 'C001', 'Zack', '123 Z St', '555-0001', 'zack@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (2, 'CASH', 'C002', 'Alice', '123 A St', '555-0002', 'alice1@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (3, 'CARD', 'C003', 'Alice', '456 A St', '555-0003', 'alice2@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (4, 'PAYPAL', 'C004', NULL, '789 N St', '555-0004', 'null@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (5, 'CASH', 'C005', 'Bob', '123 B St', '555-0005', 'bob@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (6, 'CARD', 'C006', 'Charlie', '123 C St', '555-0006', 'charlie@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (7, 'CARD', 'C007', 'David', '123 D St', '555-0007', 'david@example.com');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (10, 'HW', 'keyboard', 29.99);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (20, 'HW', 'Keyboard', 39.99);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (30, 'HW', 'wireless keyboard', 49.99);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (40, 'HW', 'mouse', 19.99);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (50, 'HW', 'keyboard', 59.99);
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (100, 1, 'COMPLETED', '2023-01-01 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (101, 2, 'COMPLETED', '2023-01-02 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (102, 2, 'PENDING', '2023-01-03 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (103, 3, 'COMPLETED', '2023-01-04 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (104, 4, 'COMPLETED', '2023-01-05 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (105, 5, 'CANCELLED', '2023-01-06 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (106, 6, 'PENDING', '2023-01-07 10:00:00');
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1000, 10, 100);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1001, 10, 100);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1002, 10, 101);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1003, 50, 102);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1004, 10, 103);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1005, 10, 104);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1006, 20, 105);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1007, 30, 105);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1008, 40, 105);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."order_id" AS "order_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "LHS"."order_item_id" AS "order_item_id", "LHS"."product_id" AS "product_id", "RHS"."product_type_code" AS "product_type_code", "RHS"."product_name" AS "product_name", "RHS"."product_price" AS "product_price" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."order_id" AS "order_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "RHS"."order_item_id" AS "order_item_id", "RHS"."product_id" AS "product_id" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "RHS"."order_id" AS "order_id", "RHS"."order_status_code" AS "order_status_code", "RHS"."order_date" AS "order_date" FROM "customers" AS "LHS" INNER JOIN "customer_orders" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id")) AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_name" = 'keyboard')) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id JOIN order_items AS T3 ON T2.order_id = T3.order_id JOIN products AS T4 ON T3.product_id = T4.product_id WHERE T4.product_name = 'keyboard';

/*
Prediction Result:
('Zack',)
('Alice',)
(None,)
*/