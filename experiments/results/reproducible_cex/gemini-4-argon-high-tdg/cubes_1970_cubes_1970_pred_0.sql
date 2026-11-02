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
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (1, '999 Wrong Address St');
INSERT INTO "Addresses" ("address_id", "address_details") VALUES (2, '888 Decoy Ave');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1, 'CARD', 'CUST001', 'Zara Vance', '742 Evergreen Terrace', '555-0101', 'zara@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (2, 'CASH', 'CUST002', 'Alice Monroe', '101 Maple Ave', '555-0102', 'alice@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (3, 'CARD', 'CUST003', 'Bob Harper', '202 Oak St', '555-0103', 'bob@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (4, 'WIRE', 'CUST004', 'Charlie Day', '303 Pine Rd', '555-0104', 'charlie@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_code", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (5, 'CASH', 'CUST005', 'Diana Prince', '404 Cedar Ln', '555-0105', 'diana@example.com');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_from", "date_to") VALUES (2, 1, '2022-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_from", "date_to") VALUES (3, 2, '2022-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (101, 1, 'New', '2023-05-01 10:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (102, 1, 'New', '2023-05-02 11:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (103, 2, 'New', '2023-05-03 12:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (104, 2, 'Pending', '2023-05-04 13:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (105, 3, 'Pending', '2023-05-05 14:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (106, 4, 'Completed', '2023-05-06 15:00:00');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status_code", "order_date") VALUES (107, 4, 'Cancelled', '2023-05-07 16:00:00');
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1, 'ELEC', 'Laptop', 999.99);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (1, 1, 101);
INSERT INTO "Order_Items" ("order_item_id", "product_id", "order_id") VALUES (2, 1, 101);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "customer_name", "customer_address" FROM (SELECT "LHS"."order_id" AS "order_id", "LHS"."customer_id" AS "customer_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "RHS"."payment_method_code" AS "payment_method_code", "RHS"."customer_code" AS "customer_code", "RHS"."customer_name" AS "customer_name", "RHS"."customer_address" AS "customer_address", "RHS"."customer_phone" AS "customer_phone", "RHS"."customer_email" AS "customer_email" FROM (SELECT * FROM "customer_orders" WHERE ("order_status_code" = 'New' AND "order_status_code" <> 'Pending')) AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_name, "customer_name" NULLS LAST, "customer_address" NULLS LAST;

/*
Gold Result:
('Alice Monroe', '101 Maple Ave')
('Zara Vance', '742 Evergreen Terrace')
*/

-- Prediction Query
SELECT T1.customer_name, T1.customer_address FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status_code = 'New' INTERSECT SELECT T1.customer_name, T1.customer_address FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id WHERE T2.order_status_code = 'Pending';

/*
Prediction Result:
('Alice Monroe', '101 Maple Ave')
*/