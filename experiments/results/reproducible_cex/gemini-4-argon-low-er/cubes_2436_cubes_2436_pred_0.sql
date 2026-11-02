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
INSERT INTO "Addresses" ("address_id", "state_province_county") VALUES (1, 'Colorado');
INSERT INTO "Customers" ("customer_id", "customer_name") VALUES (1, 'B'), (2, 'A');
INSERT INTO "Customer_Addresses" ("customer_id", "address_id") VALUES (1, 1), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "customer_name" FROM (SELECT "LHS"."address_id" AS "address_id", "LHS"."address_content" AS "address_content", "LHS"."city" AS "city", "LHS"."zip_postcode" AS "zip_postcode", "LHS"."state_province_county" AS "state_province_county", "LHS"."country" AS "country", "LHS"."other_address_details" AS "other_address_details", "LHS"."customer_id" AS "customer_id", "LHS"."payment_method" AS "payment_method", "LHS"."customer_name" AS "customer_name", "LHS"."date_became_customer" AS "date_became_customer", "LHS"."other_customer_details" AS "other_customer_details", "RHS"."date_address_from" AS "date_address_from", "RHS"."address_type" AS "address_type", "RHS"."date_address_to" AS "date_address_to" FROM (SELECT "LHS"."address_id" AS "address_id", "LHS"."address_content" AS "address_content", "LHS"."city" AS "city", "LHS"."zip_postcode" AS "zip_postcode", "LHS"."state_province_county" AS "state_province_county", "LHS"."country" AS "country", "LHS"."other_address_details" AS "other_address_details", "RHS"."customer_id" AS "customer_id", "RHS"."payment_method" AS "payment_method", "RHS"."customer_name" AS "customer_name", "RHS"."date_became_customer" AS "date_became_customer", "RHS"."other_customer_details" AS "other_customer_details" FROM "addresses" AS "LHS" CROSS JOIN "customers" AS "RHS") AS "LHS" INNER JOIN "customer_addresses" AS "RHS" ON ("LHS"."address_id" = "RHS"."address_id" AND "LHS"."customer_id" = "RHS"."customer_id")) WHERE ("state_province_county" = 'Colorado') ORDER BY customer_name, "customer_name" NULLS LAST;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT t1.customer_name FROM customers AS t1 JOIN customer_addresses AS t2 ON t1.customer_id = t2.customer_id JOIN addresses AS t3 ON t2.address_id = t3.address_id WHERE t3.state_province_county = 'Colorado';

/*
Prediction Result:
('B',)
('A',)
*/