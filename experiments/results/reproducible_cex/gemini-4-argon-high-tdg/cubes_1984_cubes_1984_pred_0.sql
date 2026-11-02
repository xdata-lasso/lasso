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
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CC', 'C100', 'Acme Corp', '123 Main St', '555-0100', 'info@acme.com');
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (1, 'Books', 'Zebra Guide', 1500.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (2, 'Books', 'Apple Manual', 500.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (3, 'Books', 'Mango Compendium', 2000.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (4, 'Books', 'Boundary Low Out', 500.01);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (5, 'Books', 'Boundary High Out', 1000.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (6, 'Electronics', 'Laptop Pro', 1000.01);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (7, 'Electronics', 'Cheap Cable', 499.99);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (8, 'Electronics', 'Mid Monitor', 750.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (9, 'Apparel', 'Winter Coat', 0.0);
INSERT INTO Products (product_id, product_type_code, product_name, product_price) VALUES (10, 'Apparel', 'Mystery Item', NULL);
INSERT INTO Customer_Orders (order_id, customer_id, order_date, order_status_code) VALUES (100, 1, '2023-01-15 10:00:00', 'Completed');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (100, 1, 1, '2');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (100, 1, 2, '5');
INSERT INTO Order_Items (order_id, product_id, order_item_id, order_quantity) VALUES (100, 5, 3, '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_type_code, product_name FROM products WHERE (product_price > 1000.0 OR product_price <= 500.0) ORDER BY product_type_code, products.product_id NULLS LAST;

/*
Gold Result:
('Apparel', 'Winter Coat')
('Books', 'Zebra Guide')
('Books', 'Apple Manual')
('Books', 'Mango Compendium')
('Electronics', 'Laptop Pro')
('Electronics', 'Cheap Cable')
*/

-- Prediction Query
SELECT product_type_code, product_name FROM products WHERE product_price > 1000 OR product_price < 500;

/*
Prediction Result:
('Books', 'Zebra Guide')
('Books', 'Mango Compendium')
('Electronics', 'Laptop Pro')
('Electronics', 'Cheap Cable')
('Apparel', 'Winter Coat')
*/