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
-- Tests basic matching, DISTINCT on duplicate channel_codes, ORDER BY ascending vs descending, NULLS LAST vs NULLS FIRST, and filtering out other customers.
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Credit Card', 'Tillman Ernser', '2022-01-01 10:00:00', 'VIP');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'Cash', 'John Doe', '2022-02-01 10:00:00', 'Regular');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'SMS', '2022-01-01 00:00:00', '2023-01-01 00:00:00', '555-0101');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Email', '2022-01-01 00:00:00', '2023-01-01 00:00:00', 'tillman@example.com');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Email', '2022-06-01 00:00:00', '2023-06-01 00:00:00', 'ternser@example.com');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, NULL, '2022-06-01 00:00:00', '2023-06-01 00:00:00', '555-0000');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'Fax', '2022-02-01 00:00:00', '2023-02-01 00:00:00', '555-0202');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "channel_code" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "RHS"."channel_code" AS "channel_code", "RHS"."active_from_date" AS "active_from_date", "RHS"."active_to_date" AS "active_to_date", "RHS"."contact_number" AS "contact_number" FROM "customers" AS "LHS" LEFT JOIN "customer_contact_channels" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) WHERE ("customer_name" = 'Tillman Ernser') ORDER BY channel_code, "channel_code" NULLS LAST;

/*
Gold Result:
(None,)
('Email',)
('SMS',)
*/

-- Prediction Query
SELECT DISTINCT channel_code FROM customers AS t1 JOIN customer_contact_channels AS t2 ON t1.customer_id = t2.customer_id WHERE t1.customer_name = 'Tillman Ernser';

/*
Prediction Result:
('SMS',)
('Email',)
(None,)
*/