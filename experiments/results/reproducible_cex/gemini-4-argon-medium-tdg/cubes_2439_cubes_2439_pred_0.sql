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
-- Tests basic ordering by city (ASC vs DESC), duplicate city preservation (SELECT vs SELECT DISTINCT),
-- and secondary sorting on address_id with non-aligned other columns (e.g. zip_postcode, country).
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (10, '456 Oak Ave', 'Chicago', '60602', 'IL', 'USA', 'Suite 200');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, '789 Pine Rd', 'Austin', '73301', 'TX', 'USA', 'Apt 4B');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (5, '123 Maple St', 'Boston', '02108', 'MA', 'USA', 'Floor 1');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, '321 Elm St', 'Boston', '02199', 'MA', 'USA', 'Floor 3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM addresses ORDER BY city, addresses.address_id NULLS LAST;

/*
Gold Result:
('Austin',)
('Boston',)
('Boston',)
('Chicago',)
*/

-- Prediction Query
SELECT DISTINCT city FROM addresses;

/*
Prediction Result:
('Boston',)
('Austin',)
('Chicago',)
*/