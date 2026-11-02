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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'lhs_c17cb2', 'Tillman Ernser', '2024-06-15 00:00:00+00:00', 'lhs_633da8');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'lhs_c17cb2', 'Tillman Ernser', '2024-06-15 00:00:00+00:00', 'lhs_633da8');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'cus_9c1fa8', 'cus_8d1b6b', '2024-12-15 00:56:33+00:00', 'cus_b7724f');

-- Inserting into table: customer_contact_channels --
INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_2e33f5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_c3ff15');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_2e33f5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_c3ff15');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_2e33f5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_c3ff15');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_2e33f5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_c3ff15');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_2e33f5', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_c3ff15');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', NULL, 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', NULL);

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', NULL, '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');

INSERT INTO "customer_contact_channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'rhs_40aa35', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'rhs_ca03da');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "channel_code" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "RHS"."channel_code" AS "channel_code", "RHS"."active_from_date" AS "active_from_date", "RHS"."active_to_date" AS "active_to_date", "RHS"."contact_number" AS "contact_number" FROM "customers" AS "LHS" LEFT JOIN "customer_contact_channels" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) WHERE ("customer_name" = 'Tillman Ernser') ORDER BY channel_code, "channel_code" NULLS LAST;

/*
Gold Result:
(None,)
('rhs_2e33f5',)
('rhs_40aa35',)
*/

-- Prediction Query
SELECT DISTINCT channel_code FROM customers AS t1 JOIN customer_contact_channels AS t2 ON t1.customer_id = t2.customer_id WHERE t1.customer_name = 'Tillman Ernser';

/*
Prediction Result:
('rhs_40aa35',)
('rhs_2e33f5',)
*/