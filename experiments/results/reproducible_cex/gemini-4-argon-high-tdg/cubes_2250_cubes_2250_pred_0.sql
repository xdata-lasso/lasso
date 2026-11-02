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
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Credit Card', 'Zoe', '555-0101', 'zoe@example.com', '101 Main St', 'zoe1', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'PayPal', 'Alice', '555-0102', 'alice@example.com', '102 Main St', 'alice2', 'pass2');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (3, 'Credit Card', 'Bob', '555-0103', 'bob@example.com', '103 Main St', 'bob3', 'pass3');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (4, 'Debit Card', 'Charlie', '555-0104', 'charlie@example.com', '104 Main St', 'charlie4', 'pass4');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (5, 'Cash', 'David', '555-0105', 'david@example.com', '105 Main St', 'david5', 'pass5');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (1, 'Electronics', 'Spring Sale', '2023-03-01 00:00:00', '2023-03-31 23:59:59');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (2, 'Books', 'Summer Reads', '2023-06-01 00:00:00', '2023-06-30 23:59:59');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (3, 'Clothing', 'Autumn Fashion', '2023-09-01 00:00:00', '2023-09-30 23:59:59');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (1, 1, 'Order', '2023-03-05 10:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 1, 'Order', '2023-06-05 10:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (1, 2, 'Order', '2023-03-06 11:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 2, 'Order', '2023-06-06 11:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (3, 2, 'Order', '2023-09-06 11:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (1, 3, 'Order', '2023-03-07 12:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 3, 'No Response', '2023-06-07 12:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (3, 3, 'No Response', '2023-09-07 12:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (1, 4, 'No Response', '2023-03-08 13:00:00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (2, 4, 'No Response', '2023-06-08 13:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT * FROM "customers" AS "LHS" WHERE EXISTS(SELECT 1 FROM (SELECT * FROM (SELECT "customer_id", "outcome_code", COUNT(*) AS "n" FROM "mailshot_customers" GROUP BY "customer_id", "outcome_code") WHERE ("outcome_code" = 'Order' AND n >= 2)) AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T2.customer_name FROM mailshot_customers AS T1 JOIN customers AS T2 ON T1.customer_id = T2.customer_id WHERE outcome_code = 'Order' GROUP BY T1.customer_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zoe',)
('Alice',)
*/