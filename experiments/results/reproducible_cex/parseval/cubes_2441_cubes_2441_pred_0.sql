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
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (-2147483648, 'cus_9c1fa8', 'cus_8d1b6b', '2024-12-15 00:56:33+00:00', 'cus_b7724f');

-- Inserting into table: customer_contact_channels --
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2025-11-23 07:28:46+00:00', '2025-10-14 06:39:08+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2021-05-28 17:00:04+00:00', '2024-02-19 01:18:26+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2022-12-08 21:38:59+00:00', '2023-01-16 20:10:41+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2020-04-30 03:21:27+00:00', '2020-10-31 07:51:16+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2020-09-25 19:25:33+00:00', '2020-07-23 07:32:15+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, NULL, '2025-06-13 15:31:02+00:00', '2021-01-07 01:22:28+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, NULL, '2021-02-21 20:09:01+00:00', '2020-01-15 18:18:33+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, NULL, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, NULL, '2023-05-25 17:04:36+00:00', '2020-12-10 17:36:20+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, NULL, '2025-08-22 00:34:24+00:00', '2022-04-13 09:01:25+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2020-04-05 14:43:51+00:00', '2020-03-08 22:40:47+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2024-04-12 00:38:47+00:00', '2021-07-31 11:04:01+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2020-12-19 01:52:21+00:00', '2022-11-06 10:19:41+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2021-07-11 07:27:32+00:00', '2022-07-30 13:34:14+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2021-01-23 18:11:33+00:00', '2021-07-20 10:41:36+00:00', 'cus_e9769c');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (-2147483648, 'cus_9e81c1', '2025-02-07 06:53:31+00:00', '2021-10-06 00:40:57+00:00', 'cus_e9769c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code FROM (SELECT channel_code, COUNT(DISTINCT customer_id) AS n_distinct FROM customer_contact_channels GROUP BY channel_code) WHERE (n_distinct <= 5) ORDER BY channel_code;

/*
Gold Result:
(None,)
('cus_9e81c1',)
*/

-- Prediction Query
SELECT channel_code FROM customer_contact_channels GROUP BY channel_code HAVING COUNT(customer_id) < 5;

/*
Prediction Result:
*/