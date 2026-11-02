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
-- Inserting into table: addresses --
INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (1, 'add_f01a88', 'Gleasonmouth', 'add_1a011c', 'Texas', 'add_d0ad81', 'add_cc877a');

INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483647, 'add_18f922', 'Gleasonmouth', 'add_4e550f', 'Texas', 'add_390ccf', 'add_21112a');

INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483646, 'q_0_12488b', 'add_ae09f0', 'add_92aefd', 'Texas', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (-2147483645, 'q_0_12488b', 'add_ae09f0', 'add_92aefd', 'Texas', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (2, 'add_abbd70', 'Gleasonmouth', 'add_92aefd', 'add_7d1289', 'add_0b134e', 'add_ea5be5');

INSERT INTO "addresses" ("address_id", "address_content", "city", "zip_postcode", "state_province_county", "country", "other_address_details") VALUES (3, 'add_abbd70', 'Gleasonmouth', 'add_92aefd', 'add_7d1289', 'add_0b134e', 'add_ea5be5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "address_content" FROM (SELECT * FROM "addresses" WHERE ("city" = 'East Julianaside' OR "city" = 'Gleasonmouth')) WHERE ("state_province_county" = 'Texas' OR "state_province_county" = 'Arizona') ORDER BY address_content, "address_content" NULLS LAST;

/*
Gold Result:
('add_18f922',)
('add_f01a88',)
*/

-- Prediction Query
SELECT address_content FROM addresses WHERE city = 'East Julianaside' AND state_province_county = 'Texas' UNION SELECT address_content FROM addresses WHERE city = 'Gleasonmouth' AND state_province_county = 'Arizona';

/*
Prediction Result:
*/