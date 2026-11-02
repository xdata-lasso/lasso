-- Schema DDL
CREATE TABLE "Premises" ("premise_id" INTEGER PRIMARY KEY, "premises_type" TEXT(15), "premise_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "product_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "customer_address" TEXT(255), "customer_login" TEXT(80), "customer_password" TEXT(10));

CREATE TABLE "Mailshot_Campaigns" ("mailshot_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "mailshot_name" TEXT(80), "mailshot_start_date" DATETIME, "mailshot_end_date" DATETIME);

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "premise_id" INTEGER, "date_address_from" DATETIME, "address_type_code" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("premise_id") REFERENCES "Premises" ("premise_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(15), "shipping_method_code" TEXT(15), "order_placed_datetime" DATETIME, "order_delivered_datetime" DATETIME, "order_shipping_charges" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Mailshot_Customers" ("mailshot_id" INTEGER, "customer_id" INTEGER, "outcome_code" TEXT(15), "mailshot_customer_date" DATETIME, FOREIGN KEY ("mailshot_id") REFERENCES "Mailshot_Campaigns" ("mailshot_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "item_id" INTEGER, "order_item_status_code" TEXT(15), "item_status_code" TEXT(15), "item_delivered_datetime" DATETIME, "item_order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (101, 'Residential', '123 Maple St');
INSERT INTO Products (product_id, product_category, product_name) VALUES (201, 'Electronics', 'Laptop');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Credit Card', 'Charlie', '555-0300', 'charlie@example.com', '789 Pine Rd', 'charlie_c', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'PayPal', 'Alice', '555-0100', 'alice1@example.com', '123 Maple St', 'alice_1', 'pass2');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (3, 'Debit Card', 'Bob', '555-0200', 'bob@example.com', '456 Oak Ave', 'bob_b', 'pass3');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (4, 'Cash', 'Alice', '555-0050', 'alice2@example.com', '321 Elm St', 'alice_2', 'pass4');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (5, 'Credit Card', 'Zoe', '555-0900', 'zoe@example.com', '654 Birch Ln', 'zoe_z', 'pass5');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (2, 'Electronics', 'Spring Sale', '2023-03-01 00:00:00', '2023-03-31 23:59:59');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (4, 'Books', 'Summer Reads', '2023-06-01 00:00:00', '2023-06-30 23:59:59');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 1, 'Opened', '2023-03-05 10:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 3, 'Clicked', '2023-03-06 11:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (4, 3, 'Ignored', '2023-06-10 14:30:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (2, 101, '2022-01-01 00:00:00', 'Home', '2023-12-31 00:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (301, 2, 'Delivered', 'Express', '2023-04-01 09:00:00', '2023-04-03 15:00:00', '10.00');
INSERT INTO Order_Items (order_id, product_id, item_id, order_item_status_code, item_status_code, item_delivered_datetime, item_order_quantity) VALUES (301, 201, 1, 'Shipped', 'OK', '2023-04-03 15:00:00', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM mailshot_customers AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, customer_phone NULLS LAST;

/*
Gold Result:
('Alice', '555-0050')
('Alice', '555-0100')
('Zoe', '555-0900')
*/

-- Prediction Query
SELECT customer_name, customer_phone FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM mailshot_customers);

/*
Prediction Result:
('Alice', '555-0100')
('Alice', '555-0050')
('Zoe', '555-0900')
*/