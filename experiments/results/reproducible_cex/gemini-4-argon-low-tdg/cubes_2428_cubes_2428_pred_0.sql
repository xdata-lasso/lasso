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
-- Core test: Duplicates for DISTINCT, reverse insertion order for ORDER BY, and orphaned customers (no orders/addresses/channels) to refute unnecessary INNER JOINs.
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, '123 Main St', 'Seattle', '98101', 'WA', 'USA', 'Apt 4');
INSERT INTO "Products" ("product_id", "product_details") VALUES (1, 'Laptop');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'PayPal', 'Alice Smith', '2022-01-15 10:00:00', 'VIP');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'Credit Card', 'Bob Jones', '2021-06-20 14:30:00', 'Regular');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'Credit Card', 'Charlie Brown', '2023-03-10 09:15:00', 'New');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (4, 'Cash', 'Diana Prince', '2020-11-05 16:45:00', 'Inactive');
-- Only Customer 2 has related records in child tables; Customers 1, 3, and 4 do not.
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_address_from", "address_type", "date_address_to") VALUES (2, 1, '2021-06-20 14:30:00', 'Billing', '2025-06-20 14:30:00');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'Email', '2021-06-20 14:30:00', '2025-06-20 14:30:00', '555-0199');
INSERT INTO "Customer_Orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (101, 2, 'Completed', '2022-02-01 11:00:00', 'Express');
INSERT INTO "Order_Items" ("order_id", "product_id", "order_quantity") VALUES (101, 1, '2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method FROM customers ORDER BY payment_method;

/*
Gold Result:
('Cash',)
('Credit Card',)
('PayPal',)
*/

-- Prediction Query
SELECT DISTINCT payment_method FROM customers;

/*
Prediction Result:
('PayPal',)
('Credit Card',)
('Cash',)
*/