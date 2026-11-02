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
INSERT INTO Products (product_id, product_details) VALUES (1, 'Monitor');
INSERT INTO Products (product_id, product_details) VALUES (2, 'Webcam');
INSERT INTO Products (product_id, product_details) VALUES (3, 'Keyboard');
INSERT INTO Products (product_id, product_details) VALUES (4, 'Monitor');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (101, 'Credit Card', 'Alice Smith', '2022-01-15 10:00:00', 'VIP Customer');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1001, 101, 'Completed', '2022-02-01 12:00:00', 'First Order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1002, 101, 'Pending', '2022-02-05 14:30:00', 'Second Order');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1001, 1, '2');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1002, 1, '5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT product_details FROM products ORDER BY product_details, products.product_id NULLS LAST;

/*
Gold Result:
('Keyboard',)
('Monitor',)
('Monitor',)
('Webcam',)
*/

-- Prediction Query
SELECT DISTINCT product_details FROM products;

/*
Prediction Result:
('Monitor',)
('Webcam',)
('Keyboard',)
*/