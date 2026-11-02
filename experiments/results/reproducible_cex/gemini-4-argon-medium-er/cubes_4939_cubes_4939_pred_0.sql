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
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Card', 'Alice', '2020-01-01', 'None');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Email', '2020-01-01', '2021-01-01', '12345');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Phone', '2020-01-01', '2022-01-01', '67890');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code, contact_number FROM (SELECT * FROM (SELECT * FROM customer_contact_channels ORDER BY active_from_date, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST) LIMIT 17);

/*
Gold Result:
('Email', '12345')
('Phone', '67890')
*/

-- Prediction Query
SELECT channel_code, contact_number FROM customer_contact_channels WHERE active_to_date - active_from_date = (SELECT active_to_date - active_from_date FROM customer_contact_channels ORDER BY (active_to_date - active_from_date) DESC, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_from_date NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST LIMIT 1);

/*
Prediction Result:
('Phone', '67890')
*/