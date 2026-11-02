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
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, '400 Oak St', 'East Julianaside', '75001', 'Texas', 'USA', 'Corner lot');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, '100 Pine St', 'East Julianaside', '85001', 'Arizona', 'USA', 'Near park');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, '300 Maple Ave', 'Gleasonmouth', '75002', 'Texas', 'USA', 'Suite 200');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (4, '200 Cedar Ln', 'Gleasonmouth', '85002', 'Arizona', 'USA', 'Floor 3');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (5, '500 Birch Rd', 'East Julianaside', '90001', 'California', 'USA', 'No match state');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (6, '600 Elm Blvd', 'Gleasonmouth', '89001', 'Nevada', 'USA', 'No match state');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (7, '700 Walnut Way', 'Austin', '73301', 'Texas', 'USA', 'No match city');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (8, '800 Spruce Ct', 'Phoenix', '85003', 'Arizona', 'USA', 'No match city');
INSERT INTO "Addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (9, '900 Ash Dr', 'Seattle', '98101', 'Washington', 'USA', 'Neither match');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Credit Card', 'Alice Smith', '2022-01-15 10:00:00', 'VIP');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_address_from", "address_type", "date_address_to") VALUES (1, 1, '2022-01-15 10:00:00', 'Billing', '2023-01-15 10:00:00');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id", "date_address_from", "address_type", "date_address_to") VALUES (1, 1, '2023-01-16 10:00:00', 'Shipping', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_content" FROM (SELECT * FROM "addresses" WHERE ("city" = 'East Julianaside' OR "city" = 'Gleasonmouth')) WHERE ("state_province_county" = 'Texas' OR "state_province_county" = 'Arizona') ORDER BY address_content, "address_content" NULLS LAST;

/*
Gold Result:
('100 Pine St',)
('200 Cedar Ln',)
('300 Maple Ave',)
('400 Oak St',)
*/

-- Prediction Query
SELECT address_content FROM addresses WHERE city = 'East Julianaside' AND state_province_county = 'Texas' UNION SELECT address_content FROM addresses WHERE city = 'Gleasonmouth' AND state_province_county = 'Arizona';

/*
Prediction Result:
('200 Cedar Ln',)
('400 Oak St',)
*/