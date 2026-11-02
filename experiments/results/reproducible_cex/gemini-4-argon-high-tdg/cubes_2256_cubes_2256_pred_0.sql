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
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Credit Card', 'Charlie', '555-0101', 'charlie@example.com', '101 Main St', 'charlie_l', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'PayPal', 'Alice', '555-0102', 'alice@example.com', '102 Main St', 'alice_l', 'pass2');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (3, 'Debit Card', 'Bob', '555-0103', 'bob@example.com', '103 Main St', 'bob_l', 'pass3');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (4, 'Cash', 'David', '555-0104', 'david@example.com', '104 Main St', 'david_l', 'pass4');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (5, 'Credit Card', 'Aaron', '555-0105', 'aaron@example.com', '105 Main St', 'aaron_l', 'pass5');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (6, 'Credit Card', 'Eve', '555-0106', 'eve@example.com', '106 Main St', 'eve_l', 'pass6');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (10, 1, 'Paid', 'FedEx', '2023-01-10 10:00:00', '2023-01-12 10:00:00', '15.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (20, 2, 'Pending', 'FedEx', '2023-01-11 10:00:00', '2023-01-13 10:00:00', '15.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (30, 3, 'Paid', 'UPS', '2023-01-12 10:00:00', '2023-01-14 10:00:00', '12.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (40, 4, 'Cancelled', 'DHL', '2023-01-13 10:00:00', NULL, '20.00');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (50, 5, 'Paid', 'FedEx', '2023-01-14 10:00:00', '2023-01-16 10:00:00', '10.00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."customer_phone" AS "customer_phone", "LHS"."customer_email" AS "customer_email", "LHS"."customer_address" AS "customer_address", "LHS"."customer_login" AS "customer_login", "LHS"."customer_password" AS "customer_password", "RHS"."order_id" AS "order_id", "RHS"."order_status_code" AS "order_status_code", "RHS"."shipping_method_code" AS "shipping_method_code", "RHS"."order_placed_datetime" AS "order_placed_datetime", "RHS"."order_delivered_datetime" AS "order_delivered_datetime", "RHS"."order_shipping_charges" AS "order_shipping_charges" FROM "customers" AS "LHS" INNER JOIN (SELECT * FROM "customer_orders" WHERE ("shipping_method_code" = 'FedEx' AND "order_status_code" = 'Paid')) AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('Aaron',)
('Charlie',)
*/

-- Prediction Query
SELECT T1.customer_name FROM customers AS T1 JOIN customer_orders AS T2 ON T1.customer_id = T2.customer_id WHERE shipping_method_code = 'FedEx' AND order_status_code = 'Paid';

/*
Prediction Result:
('Charlie',)
('Aaron',)
*/