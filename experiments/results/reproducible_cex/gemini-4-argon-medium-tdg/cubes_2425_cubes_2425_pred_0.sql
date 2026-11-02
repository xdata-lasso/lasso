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
-- Tests basic WHERE filtering ('Cash' vs other values, case sensitivity, substrings, NULLs)
-- and basic ORDER BY customer_name (where insertion/PK order conflicts with alphabetical order).
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Cash', 'Zack', '2022-01-10 10:00:00', 'Detail 1');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'Credit Card', 'Aaron', '2021-05-15 08:30:00', 'Detail 2');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'cash', 'Bella', '2020-03-20 12:00:00', 'Detail 3');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (4, 'Cashier Check', 'Charlie', '2023-07-01 09:15:00', 'Detail 4');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (5, NULL, 'David', '2019-11-11 14:45:00', 'Detail 5');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (6, 'Cash', 'Alice', '2023-02-28 16:20:00', 'Detail 6');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (7, 'Cash', 'Bob', '2018-08-08 11:10:00', 'Detail 7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM "customers" WHERE ("payment_method" = 'Cash') ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Bob',)
('Zack',)
*/

-- Prediction Query
SELECT customer_name FROM customers WHERE payment_method = 'Cash';

/*
Prediction Result:
('Zack',)
('Alice',)
('Bob',)
*/