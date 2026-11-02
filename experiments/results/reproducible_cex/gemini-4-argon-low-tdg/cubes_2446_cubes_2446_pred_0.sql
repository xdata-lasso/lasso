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
-- DATASET 2
-- Tests NULL semantics in the self-join of Customer_Contact_Channels (active_to_date or contact_number being NULL should fail equality in the Reference Query's self-join).
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Card', 'David', '2019-01-01', 'Details1');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'Cash', 'Eve', '2019-02-01', 'Details2');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'Card', 'Frank', '2019-03-01', 'Details3');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (4, 'Cash', 'Grace', '2019-04-01', 'Details4');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (1, 'Email', '2021-01-01', NULL, 'david@example.com');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (2, 'Email', '2021-02-01', '2022-02-01', NULL);
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (3, 'Email', NULL, '2022-03-01', 'frank@example.com');
INSERT INTO "Customer_Contact_Channels" ("customer_id", "channel_code", "active_from_date", "active_to_date", "contact_number") VALUES (4, 'Email', '2021-04-01', '2022-04-01', 'grace@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name", "active_from_date" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "LHS"."channel_code" AS "channel_code", "LHS"."active_from_date" AS "active_from_date", "LHS"."active_to_date" AS "active_to_date", "LHS"."contact_number" AS "contact_number" FROM (SELECT "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "RHS"."channel_code" AS "channel_code", "RHS"."active_from_date" AS "active_from_date", "RHS"."active_to_date" AS "active_to_date", "RHS"."contact_number" AS "contact_number" FROM "customers" AS "LHS" INNER JOIN "customer_contact_channels" AS "RHS" ON ("LHS"."customer_id" = "RHS"."customer_id")) AS "LHS" INNER JOIN (SELECT * FROM "customer_contact_channels" WHERE ("channel_code" = 'Email')) AS RHS ON (LHS.customer_id = RHS.customer_id AND LHS.channel_code = RHS.channel_code AND LHS.active_from_date = RHS.active_from_date AND LHS.active_to_date = RHS.active_to_date AND LHS.contact_number = RHS.contact_number)) ORDER BY customer_name, "customer_name" NULLS LAST, "active_from_date" NULLS LAST;

/*
Gold Result:
('Grace', '2021-04-01')
*/

-- Prediction Query
SELECT t1.customer_name, t2.active_from_date FROM customers AS t1 JOIN customer_contact_channels AS t2 ON t1.customer_id = t2.customer_id WHERE t2.channel_code = 'Email';

/*
Prediction Result:
('David', '2021-01-01')
('Eve', '2021-02-01')
('Frank', None)
('Grace', '2021-04-01')
*/