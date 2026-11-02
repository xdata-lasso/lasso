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
-- Tests boundary values around 10 and 20, reverse insertion order to verify ORDER BY, and duplicate dates to check the ausencia of DISTINCT.
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (25, 'Card', 'Alice', '2021-01-01 00:00:00', 'Detail 1');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (21, 'Cash', 'Bob', '2020-06-15 12:00:00', 'Detail 2');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (20, 'Card', 'Charlie', '2020-01-01 08:30:00', 'Detail 3');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (19, 'Wire', 'David', '2019-11-20 14:45:00', 'Detail 4');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (15, 'Card', 'Eve', '2020-06-15 12:00:00', 'Detail 5');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (11, 'Cash', 'Frank', '2018-05-05 09:00:00', 'Detail 6');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (10, 'Wire', 'Grace', '2022-12-31 23:59:59', 'Detail 7');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (9, 'Card', 'Heidi', '2017-01-01 00:00:00', 'Detail 8');
INSERT INTO "Customers" ("customer_id", "payment_method", "customer_name", "date_became_customer", "other_customer_details") VALUES (1, 'Cash', 'Ivan', '2016-01-01 00:00:00', 'Detail 9');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_became_customer FROM customers WHERE (customer_id >= 10 OR customer_id > 20) ORDER BY date_became_customer, customers.customer_id NULLS LAST;

/*
Gold Result:
('2018-05-05 09:00:00',)
('2019-11-20 14:45:00',)
('2020-01-01 08:30:00',)
('2020-06-15 12:00:00',)
('2020-06-15 12:00:00',)
('2021-01-01 00:00:00',)
('2022-12-31 23:59:59',)
*/

-- Prediction Query
SELECT date_became_customer FROM customers WHERE customer_id BETWEEN 10 AND 20;

/*
Prediction Result:
('2022-12-31 23:59:59',)
('2018-05-05 09:00:00',)
('2020-06-15 12:00:00',)
('2019-11-20 14:45:00',)
('2020-01-01 08:30:00',)
*/