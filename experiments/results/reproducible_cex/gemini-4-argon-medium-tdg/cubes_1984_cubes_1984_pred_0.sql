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
-- Boundary value analysis for product_price (500.0, 1000.0, and values around them), NULL handling, and secondary sorting on product_id
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (1, 'Hardware', 'Cheap Mouse', 25.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (2, 'Hardware', 'Exact 500 Monitor', 500.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (3, 'Hardware', 'Just Over 500 Monitor', 500.01);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (4, 'Software', 'Mid Range OS', 750.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (5, 'Software', 'Just Under 1000 Suite', 999.99);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (6, 'Software', 'Exact 1000 Suite', 1000.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (7, 'Service', 'Just Over 1000 Support', 1000.01);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (8, 'Service', 'Enterprise Support', 2500.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (9, 'Service', 'Unpriced Service', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code, product_name FROM products WHERE (product_price > 1000.0 OR product_price <= 500.0) ORDER BY product_type_code, products.product_id NULLS LAST;

/*
Gold Result:
('Hardware', 'Cheap Mouse')
('Hardware', 'Exact 500 Monitor')
('Service', 'Just Over 1000 Support')
('Service', 'Enterprise Support')
*/

-- Prediction Query
SELECT product_type_code, product_name FROM products WHERE product_price > 1000 OR product_price < 500;

/*
Prediction Result:
('Hardware', 'Cheap Mouse')
('Service', 'Just Over 1000 Support')
('Service', 'Enterprise Support')
*/