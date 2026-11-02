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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1049, 'arm', 'Peter Garrett', '1980-02-18', 'campaign');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1050, 'cup', 'Christina Dunn', '1980-02-19', 'air');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1051, 'national', 'Jessica Wolfe', '1980-02-20', 'professor');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1052, 'world', 'Aaron Barber', '1989-11-04', 'go');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1053, 'store', 'Lauren Keller', '1989-11-05', 'old');
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1054, 'movement', 'Jill Washington', '1989-11-06', 'source');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1049, 'politics', '1983-05-21', '1986-08-01', '324.980.8613');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1049, 'politics', '1983-05-22', '1986-08-02', '527-948-4677');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1049, 'politics', '1983-05-23', '1986-08-03', '+1-826-739-8214');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1052, 'politics', '1992-03-07', '1995-06-10', '+1-867-253-3963');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1052, 'politics', '1992-03-08', '1995-06-11', '976-262-7028x95171');
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1052, 'politics', '1992-03-09', '1995-06-12', '001-826-721-7459x6158');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code FROM (SELECT channel_code, COUNT(DISTINCT customer_id) AS n_distinct FROM customer_contact_channels GROUP BY channel_code) WHERE (n_distinct <= 5) ORDER BY channel_code;

/*
Gold Result:
('politics',)
*/

-- Prediction Query
SELECT channel_code FROM customer_contact_channels GROUP BY channel_code HAVING COUNT(customer_id) < 5;

/*
Prediction Result:
*/