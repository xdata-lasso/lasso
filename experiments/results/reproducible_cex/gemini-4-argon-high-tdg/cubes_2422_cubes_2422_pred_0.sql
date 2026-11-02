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
-- DATASET 1
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2015-01-01 00:00:00', 'Excluded low ID');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (9, 'Cash', 'Bob', '2016-06-15 12:00:00', 'Excluded boundary 9');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (10, 'Card', 'Charlie', '2022-09-10 08:30:00', 'Included boundary 10');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (11, 'PayPal', 'David', '2019-03-20 14:15:00', 'Included 11');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (19, 'Wire', 'Eve', '2023-11-05 19:45:00', 'Included 19');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (20, 'Card', 'Frank', '2018-07-01 06:00:00', 'Included boundary 20');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (21, 'Cash', 'Grace', '2021-04-12 10:20:00', 'Included boundary 21');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (100, 'Check', 'Heidi', '2020-02-28 23:59:59', 'Included 100');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_became_customer FROM customers WHERE (customer_id >= 10 OR customer_id > 20) ORDER BY date_became_customer, customers.customer_id NULLS LAST;

/*
Gold Result:
('2018-07-01 06:00:00',)
('2019-03-20 14:15:00',)
('2020-02-28 23:59:59',)
('2021-04-12 10:20:00',)
('2022-09-10 08:30:00',)
('2023-11-05 19:45:00',)
*/

-- Prediction Query
SELECT date_became_customer FROM customers WHERE customer_id BETWEEN 10 AND 20;

/*
Prediction Result:
('2022-09-10 08:30:00',)
('2019-03-20 14:15:00',)
('2023-11-05 19:45:00',)
('2018-07-01 06:00:00',)
*/