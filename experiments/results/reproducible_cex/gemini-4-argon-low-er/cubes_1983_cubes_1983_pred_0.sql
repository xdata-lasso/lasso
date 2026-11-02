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
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_phone) VALUES (1, 'CARD', '100', 'Alice', '555-0100');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_phone) VALUES (2, 'CASH', '200', 'Bob', '555-0200');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alice', '555-0100', 'CARD')
('Bob', '555-0200', 'CASH')
*/

-- Prediction Query
SELECT customer_name, customer_phone, payment_method_code FROM customers ORDER BY customer_number DESC, customers.customer_id NULLS LAST;

/*
Prediction Result:
('Bob', '555-0200', 'CASH')
('Alice', '555-0100', 'CARD')
*/