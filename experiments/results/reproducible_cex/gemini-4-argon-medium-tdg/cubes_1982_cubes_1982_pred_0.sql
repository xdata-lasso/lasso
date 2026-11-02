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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '101 Main St', 'Seattle', '98101', 'WA', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (2, '202 Oak Ave', 'Portland', '97201', 'OR', 'USA');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CREDIT', 'C001', 'Alice', '101 Main St', '555-0001', 'alice@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (2, 'DEBIT', 'C002', 'Bob', '202 Oak Ave', '555-0002', 'bob@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (3, 'CASH', 'C003', 'Charlie', '303 Pine Rd', '555-0003', 'charlie@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (4, 'CREDIT', 'C004', 'Charlie', '404 Elm St', '555-0001', 'charlie2@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (5, 'PAYPAL', 'C005', 'Charlie', '505 Birch Ln', NULL, 'charlie3@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (6, 'CREDIT', 'C006', 'David', '606 Cedar Blvd', '555-0006', 'david@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (7, 'DEBIT', 'C007', 'David', '707 Walnut St', '555-0006', 'david2@example.com');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (1, 1, '2020-01-01 00:00:00', '2021-01-01 00:00:00');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (2, 1, '2021-01-02 00:00:00', '2022-01-01 00:00:00');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (1, 2, '2022-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO Contacts (contact_id, customer_id, gender, first_name, last_name, contact_phone) VALUES (1, 3, 'M', 'Charlie', 'Brown', '555-0003');
INSERT INTO Customer_Orders (order_id, customer_id, order_date, order_status_code) VALUES (1, 4, '2023-05-01 10:00:00', 'COMPLETED');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name, customer_phone FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM customer_address_history AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_name, customer_phone NULLS LAST;

/*
Gold Result:
('Charlie', '555-0001')
('Charlie', '555-0003')
('Charlie', None)
('David', '555-0006')
('David', '555-0006')
*/

-- Prediction Query
SELECT customer_name, customer_phone FROM customers WHERE NOT customer_id IN (SELECT customer_id FROM customer_address_history);

/*
Prediction Result:
('Charlie', '555-0003')
('Charlie', '555-0001')
('Charlie', None)
('David', '555-0006')
('David', '555-0006')
*/