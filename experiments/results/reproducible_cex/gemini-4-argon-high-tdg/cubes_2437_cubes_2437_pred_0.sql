-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "address_content" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50), "other_address_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "date_became_customer" DATETIME, "other_customer_details" TEXT(255));

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "address_id" INTEGER, "date_address_from" DATETIME, "address_type" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"));

CREATE TABLE "Customer_Contact_Channels" ("customer_id" INTEGER, "channel_code" TEXT(15), "active_from_date" DATETIME, "active_to_date" DATETIME, "contact_number" TEXT(50), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status" TEXT(15), "order_date" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_quantity" TEXT(15), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Credit Card', 'John Smith', '2021-01-01 08:00:00', 'Customer A');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'John Smith', '2021-06-01 09:00:00', 'Customer B');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'PayPal', 'Jane Doe', '2021-07-01 10:00:00', 'Customer C');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Debit Card', 'Jane Doe', '2021-08-01 11:00:00', 'Customer D');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Credit Card', 'Bob Brown', '2021-09-01 12:00:00', 'Customer E');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1, 4, 'Delivered', '2022-01-15 10:00:00', 'Paid');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (2, 5, 'Delivered', '2022-01-16 11:00:00', 'Paid');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_orders AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name;

/*
Gold Result:
('Jane Doe',)
('John Smith',)
('John Smith',)
*/

-- Prediction Query
SELECT customer_name FROM customers EXCEPT SELECT t1.customer_name FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id;

/*
Prediction Result:
('John Smith',)
*/