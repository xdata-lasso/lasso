-- Schema DDL
CREATE TABLE "Addresses" ("address_id" INTEGER PRIMARY KEY, "line_1_number_building" TEXT(80), "city" TEXT(50), "zip_postcode" TEXT(20), "state_province_county" TEXT(50), "country" TEXT(50));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_type_code" TEXT(15), "product_name" TEXT(80), "product_price" REAL);

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method_code" TEXT(15), "customer_number" TEXT(20), "customer_name" TEXT(80), "customer_address" TEXT(255), "customer_phone" TEXT(80), "customer_email" TEXT(80));

CREATE TABLE "Contacts" ("contact_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "gender" TEXT(1), "first_name" TEXT(80), "last_name" TEXT(50), "contact_phone" TEXT(80));

CREATE TABLE "Customer_Address_History" ("address_id" INTEGER, "customer_id" INTEGER, "date_from" DATETIME, "date_to" DATETIME, FOREIGN KEY ("address_id") REFERENCES "Addresses" ("address_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_date" DATETIME, "order_status_code" TEXT(15), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "order_item_id" INTEGER, "order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Addresses" ("address_id", "line_1_number_building", "city", "zip_postcode", "state_province_county", "country") VALUES (10, '10 First St', 'Star City', '30003', 'CA', 'USA');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (1, 'CC', 'C101', 'Zane', '10 First St', '555-9000', 'zane@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (2, 'CC', 'C102', 'Aaron', '20 Second St', NULL, 'aaron1@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (3, 'CC', 'C103', 'Aaron', '30 Third St', '555-1000', 'aaron2@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (4, 'CC', 'C104', 'Aaron', '40 Fourth St', '555-2000', 'aaron3@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (5, 'CC', 'C105', NULL, '50 Fifth St', '555-3000', 'noname@example.com');
INSERT INTO "Customers" ("customer_id", "payment_method_code", "customer_number", "customer_name", "customer_address", "customer_phone", "customer_email") VALUES (6, 'CC', 'C106', 'Bella', '60 Sixth St', '555-4000', 'bella@example.com');
INSERT INTO "Customer_Address_History" ("address_id", "customer_id", "date_from", "date_to") VALUES (10, 6, '2021-01-01 00:00:00', '2022-01-01 00:00:00');
INSERT INTO "Customer_Address_History" ("address_id", "customer_id", "date_from", "date_to") VALUES (10, NULL, '2021-06-01 00:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_address_history AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, customer_phone NULLS LAST;

/*
Gold Result:
(None, '555-3000')
('Aaron', '555-1000')
('Aaron', '555-2000')
('Aaron', None)
('Zane', '555-9000')
*/

-- Prediction Query
SELECT customer_name, customer_phone FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM customer_address_history);

/*
Prediction Result:
*/