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
-- DATASET 3
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (100, '10 Downing St', 'London', 'SW1A 2AA', 'Greater London', 'UK');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CC', 'CUST-101', 'Frank', '10 Downing St', '555-3333', 'frank@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (2, 'CC', 'CUST-102', 'Grace', '221B Baker St', '555-4444', 'grace@example.com');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (NULL, 2, '2021-03-15 00:00:00', '2022-03-15 00:00:00');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (100, NULL, '2020-01-01 00:00:00', '2020-12-31 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_address_history AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, customer_phone NULLS LAST;

/*
Gold Result:
('Frank', '555-3333')
*/

-- Prediction Query
SELECT customer_name, customer_phone FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM customer_address_history);

/*
Prediction Result:
*/