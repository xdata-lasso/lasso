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
INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'lhs_c48bf3', 'lhs_01a06b', '2024-06-15 00:00:00+00:00', 'lhs_67582b');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (-2147483647, 'lhs_affcd0', 'lhs_cd6697', '2024-06-15 00:00:00+00:00', 'lhs_d6967b');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (-2147483646, 'cus_9c1fa8', 'q_0_bae5e8', '2024-12-15 00:56:33+00:00', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (-2147483645, 'cus_9c1fa8', 'q_0_bae5e8', '2025-11-23 07:28:46+00:00', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (2, 'cus_9c1fa8', 'cus_8d1b6b', '2025-10-14 06:39:08+00:00', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (3, 'cus_9c1fa8', 'cus_8d1b6b', '2025-06-10 18:20:47+00:00', 'cus_b7724f');

-- Inserting into table: customer_orders --
INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (4, 2, 'cus_567269', '2024-02-22 05:22:28+00:00', 'cus_a07019');

INSERT INTO "customer_orders" ("order_id", "customer_id", "order_status", "order_date", "order_details") VALUES (5, 3, 'cus_567269', '2021-05-28 17:00:04+00:00', 'cus_a07019');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_orders AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name;

/*
Gold Result:
('lhs_01a06b',)
('lhs_cd6697',)
('q_0_bae5e8',)
('q_0_bae5e8',)
*/

-- Prediction Query
SELECT customer_name FROM customers EXCEPT SELECT t1.customer_name FROM customers AS t1 JOIN customer_orders AS t2 ON t1.customer_id = t2.customer_id;

/*
Prediction Result:
('lhs_01a06b',)
('lhs_cd6697',)
('q_0_bae5e8',)
*/