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
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (101, '123 Main St', 'Seattle', '98101', 'WA', 'USA', 'Apt 4B');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (102, '456 Oak Ave', 'Austin', '73301', 'TX', 'USA', 'Suite 200');
INSERT INTO "Products" ("product_id", "product_details") VALUES (201, 'Wireless Mouse');
INSERT INTO "Products" ("product_id", "product_details") VALUES (202, 'Mechanical Keyboard');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Cash', 'Alice Smith', '2021-03-15 10:00:00', 'VIP');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'PayPal', 'Bob Jones', '2020-01-10 08:30:00', 'Regular');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'Amex', 'Charlie Brown', '2022-06-20 14:15:00', 'New');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (4, 'Cash', 'Diana Prince', '2023-02-01 09:00:00', 'Regular');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (5, 'Amex', 'Evan Wright', '2019-11-05 16:45:00', 'VIP');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (6, 'Cash', 'Fiona Gallagher', '2021-08-12 11:20:00', 'Regular');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (7, 'Bitcoin', 'George Clark', '2023-09-30 19:00:00', 'Crypto user');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_address_from", "address_type", "date_address_to") VALUES (1, 101, '2021-03-15 10:00:00', 'Billing', '2024-03-15 10:00:00');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_address_from", "address_type", "date_address_to") VALUES (7, 102, '2023-09-30 19:00:00', 'Shipping', '2025-09-30 19:00:00');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Email', '2021-03-15 10:00:00', '2025-01-01 00:00:00', '555-0101');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (3, 'Mobile', '2022-06-20 14:15:00', '2025-01-01 00:00:00', '555-0103');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (301, 1, 'Completed', '2021-04-01 12:00:00', 'First order');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (302, 4, 'Pending', '2023-02-15 15:30:00', 'Second order');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (301, 201, '2');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (302, 202, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method FROM customers ORDER BY payment_method;

/*
Gold Result:
('Amex',)
('Bitcoin',)
('Cash',)
('PayPal',)
*/

-- Prediction Query
SELECT DISTINCT payment_method FROM customers;

/*
Prediction Result:
('Cash',)
('PayPal',)
('Amex',)
('Bitcoin',)
*/