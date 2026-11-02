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
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CARD', 'C001', 'Zara', '101 Main St', '555-0101', 'zara@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (2, 'CASH', 'C002', 'Mike', '102 Main St', '555-0102', 'mike@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (3, 'CARD', 'C003', 'Alice', '103 Main St', '555-0103', 'alice@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (4, 'CASH', 'C004', 'Bob', '104 Main St', '555-0104', 'bob@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (5, 'CARD', 'C005', 'Charlie', '105 Main St', '555-0105', 'charlie@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (6, 'CASH', 'C006', 'David', '106 Main St', '555-0106', 'david@example.com');
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (1000, 'ELEC', 'keyboard', 49.99);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (2000, 'ELEC', 'mouse', 19.99);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (3000, 'ELEC', 'keyboard', 89.99);
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (10, 1, 'COMPLETED', '2023-01-10 10:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (20, 2, 'PENDING', '2023-01-11 11:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (30, 3, 'COMPLETED', '2023-01-12 12:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (40, 4, 'COMPLETED', '2023-01-13 13:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (50, 5, 'CANCELLED', '2023-01-14 14:00:00');
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (100, 1000, 10);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (200, 1000, 20);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (300, 1000, 30);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (400, 2000, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."order_id" AS "order_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "LHS"."order_item_id" AS "order_item_id", "LHS"."product_id" AS "product_id", "RHS"."product_type_code" AS "product_type_code", "RHS"."product_name" AS "product_name", "RHS"."product_price" AS "product_price" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."order_id" AS "order_id", "LHS"."order_status_code" AS "order_status_code", "LHS"."order_date" AS "order_date", "RHS"."order_item_id" AS "order_item_id", "RHS"."product_id" AS "product_id" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method_code" AS "payment_method_code", "LHS"."customer_code" AS "customer_code", "LHS"."customer_name" AS "customer_name", "LHS"."customer_address" AS "customer_address", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "RHS"."order_id" AS "order_id", "RHS"."order_status_code" AS "order_status_code", "RHS"."order_date" AS "order_date" FROM "customers" AS "LHS" INNER JOIN "customer_orders" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN "order_items" AS "RHS" ON ("LHS"."order_id" = "RHS"."order_id")) AS "LHS" INNER JOIN (SELECT * FROM "products" WHERE ("product_name" = 'keyboard')) AS RHS ON (LHS.product_id = RHS.product_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Mike',)
('Zara',)
*/

-- Prediction Query
SELECT DISTINCT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id JOIN order_items AS T3 ON T2.order_id = T3.order_id JOIN products AS T4 ON T3.product_id = T4.product_id WHERE T4.product_name = 'keyboard';

/*
Prediction Result:
('Zara',)
('Mike',)
('Alice',)
*/