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
INSERT INTO Customers (customer_id, payment_method_code, customer_code, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CARD', 'C001', 'Alice', '123 Main St', '555-0100', 'alice@example.com');
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (10, 'ELEC', 'Item 10', 30.00);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (20, 'ELEC', 'Item 20', 10.00);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (30, 'ELEC', 'Item 30', 20.00);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (40, 'ELEC', 'Item 40', 100.00);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (50, 'ELEC', 'Unordered Item', 5.00);
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (100, 1, 'PAID', '2023-01-01 10:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (200, 1, 'PAID', '2023-01-02 10:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (300, 1, 'PAID', '2023-01-03 10:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, order_date) VALUES (400, 1, 'PAID', '2023-01-04 10:00:00');
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (1, 20, 100);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (2, 20, 100);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (3, 20, 100);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (4, 20, 100);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (5, 30, 200);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (6, 30, 200);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (7, 10, 300);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (8, 10, 300);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (9, 10, 300);
INSERT INTO Order_Items (order_item_id, product_id, order_id) VALUES (10, 40, 400);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT product_id FROM (SELECT LHS.order_id AS order_id, LHS.product_id AS product_id, LHS.n AS n, RHS.order_id AS order_id_other, RHS.product_id AS product_id_other, RHS.n AS n_other FROM (SELECT order_id, product_id, COUNT(*) AS n FROM order_items GROUP BY order_id, product_id) AS LHS CROSS JOIN (SELECT order_id, product_id, COUNT(*) AS n FROM order_items GROUP BY order_id, product_id) AS RHS) WHERE (n > n_other) ORDER BY product_id;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT product_id FROM order_items GROUP BY product_id ORDER BY COUNT(*) DESC, product_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(20,)
*/