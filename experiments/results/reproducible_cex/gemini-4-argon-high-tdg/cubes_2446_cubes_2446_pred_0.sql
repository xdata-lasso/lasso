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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Credit Card', 'Zoe Adams', '2018-01-10 09:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'PayPal', 'Alice Smith', '2019-06-15 14:30:00', 'Standard');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Debit Card', 'Bob Jones', '2017-03-20 11:15:00', 'Preferred');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Cash', 'Aaron Brown', '2020-11-05 08:45:00', 'New');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2022-09-01 00:00:00', '2025-09-01 00:00:00', 'zoe.late@example.com');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2020-03-15 00:00:00', '2022-08-31 00:00:00', 'zoe.early@example.com');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Phone', '2019-01-01 00:00:00', '2025-01-01 00:00:00', '555-0101');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Email', '2021-04-20 10:00:00', '2024-04-20 10:00:00', 'alice@example.com');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Mobile', '2018-07-12 00:00:00', '2023-07-12 00:00:00', '555-0103');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (10, '123 Maple St', 'Seattle', '98101', 'WA', 'USA', 'Apt 4B');
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 10, '2018-02-01 00:00:00', 'Billing', '2025-02-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 10, '2019-05-01 00:00:00', 'Shipping', '2025-05-01 00:00:00');
INSERT INTO Products (product_id, product_details) VALUES (100, 'Laptop');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (500, 1, 'Delivered', '2021-01-15 12:00:00', 'First Order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (501, 1, 'Shipped', '2021-06-15 12:00:00', 'Second Order');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (500, 100, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name", "active_from_date" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "LHS"."channel_code" AS "channel_code", "LHS"."active_from_date" AS "active_from_date", "LHS"."active_to_date" AS "active_to_date", "LHS"."contact_number" AS "contact_number" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "RHS"."channel_code" AS "channel_code", "RHS"."active_from_date" AS "active_from_date", "RHS"."active_to_date" AS "active_to_date", "RHS"."contact_number" AS "contact_number" FROM "customers" AS "LHS" INNER JOIN "customer_contact_channels" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN (SELECT * FROM "customer_contact_channels" WHERE ("channel_code" = 'Email')) AS RHS ON (LHS.customer_id = RHS.customer_id AND LHS.channel_code = RHS.channel_code AND LHS.active_from_date = RHS.active_from_date AND LHS.active_to_date = RHS.active_to_date AND LHS.contact_number = RHS.contact_number)) ORDER BY customer_name, "customer_name" NULLS LAST, "active_from_date" NULLS LAST;

/*
Gold Result:
('Alice Smith', '2021-04-20 10:00:00')
('Zoe Adams', '2020-03-15 00:00:00')
('Zoe Adams', '2022-09-01 00:00:00')
*/

-- Prediction Query
SELECT t1.customer_name, t2.active_from_date FROM customers AS t1 JOIN customer_contact_channels AS t2 ON t1.customer_id = t2.customer_id WHERE t2.channel_code = 'Email';

/*
Prediction Result:
('Zoe Adams', '2022-09-01 00:00:00')
('Zoe Adams', '2020-03-15 00:00:00')
('Alice Smith', '2021-04-20 10:00:00')
*/