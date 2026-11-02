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
-- DATASET 1
-- Tests exact boundary values for product_price (500.0, 1000.0), around boundaries, and NULLs.
-- Kills mutants changing > to >=, <= to <, OR to AND, or omitting the WHERE clause.
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (1, 'Books', 'Exact 500', 500.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (2, 'Books', 'Just Over 500', 500.01);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (3, 'Books', 'Middle Price', 750.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (4, 'Books', 'Exact 1000', 1000.0);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (5, 'Books', 'Just Over 1000', 1000.01);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (6, 'Books', 'Null Price', NULL);
INSERT INTO "Products" ("product_id", "product_type_code", "product_name", "product_price") VALUES (7, 'Books', 'Negative Price', -10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code, product_name FROM products WHERE (product_price > 1000.0 OR product_price <= 500.0) ORDER BY product_type_code, products.product_id NULLS LAST;

/*
Gold Result:
('Books', 'Exact 500')
('Books', 'Just Over 1000')
('Books', 'Negative Price')
*/

-- Prediction Query
SELECT product_type_code, product_name FROM products WHERE product_price > 1000 OR product_price < 500;

/*
Prediction Result:
('Books', 'Just Over 1000')
('Books', 'Negative Price')
*/