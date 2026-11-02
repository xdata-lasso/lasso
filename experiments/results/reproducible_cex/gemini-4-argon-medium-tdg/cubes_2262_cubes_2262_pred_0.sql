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
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Card', 'Alice', '555-0102', 'a1@test.com', 'Addr 1', 'alice1', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'Cash', 'Alice', '555-0101', 'a2@test.com', 'Addr 2', 'alice2', 'pass2');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (3, 'Card', 'Alice', NULL, 'a3@test.com', 'Addr 3', 'alice3', 'pass3');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (4, 'Card', 'Bob', '555-0200', 'b1@test.com', 'Addr 4', 'bob1', 'pass4');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (5, 'Cash', 'Bob', '555-0200', 'b2@test.com', 'Addr 5', 'bob2', 'pass5');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (6, 'Card', 'Charlie', '555-0300', 'c1@test.com', 'Addr 6', 'charlie1', 'pass6');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (7, 'Card', NULL, '555-0400', 'n1@test.com', 'Addr 7', 'null1', 'pass7');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (6, 'Tech', 'Summer Sale', '2023-06-01 00:00:00', '2023-06-30 23:59:59');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (10, 'Books', 'Winter Sale', '2023-12-01 00:00:00', '2023-12-31 23:59:59');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (10, 6, 'Success', '2023-12-05 10:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (6, 6, 'No Response', '2023-06-15 12:00:00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (100, 1, 'Delivered', 'Std', '2023-05-01 08:00:00', '2023-05-05 14:00:00', '10.00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM mailshot_customers AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, customer_phone NULLS LAST;

/*
Gold Result:
(None, '555-0400')
('Alice', '555-0101')
('Alice', '555-0102')
('Alice', None)
('Bob', '555-0200')
('Bob', '555-0200')
*/

-- Prediction Query
SELECT customer_name, customer_phone FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM mailshot_customers);

/*
Prediction Result:
('Alice', '555-0102')
('Alice', '555-0101')
('Alice', None)
('Bob', '555-0200')
('Bob', '555-0200')
(None, '555-0400')
*/