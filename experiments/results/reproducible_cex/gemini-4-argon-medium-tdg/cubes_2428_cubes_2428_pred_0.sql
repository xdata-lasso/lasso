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
-- Tests:
-- 1. Missing DISTINCT (duplicate payment_method values: 'Visa', 'PayPal').
-- 2. Missing ORDER BY or DESC instead of ASC (inserted out of alphabetical order).
-- 3. Unnecessary INNER JOIN with Customer_Orders (Customer 3 has 'Cash', which only exists on a customer with no orders).
-- 4. Unnecessary INNER JOIN with Customer_Addresses (Customer 4 has 'Amex', no address).
-- 5. Unnecessary INNER JOIN with Customer_Contact_Channels (Customer 5 has 'Check', no contact channel).
-- 6. Sorting by customer_id or customer_name instead of payment_method (customer_name and customer_id order inversely to payment_method).
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '123 Main St', 'Seattle', '98101', 'WA', 'USA', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Visa', 'Alice', '2023-01-05 10:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'PayPal', 'Bob', '2023-01-04 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Cash', 'Charlie', '2023-01-03 10:00:00', 'New');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Amex', 'David', '2023-01-02 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Check', 'Eve', '2023-01-01 10:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (6, 'Visa', 'Frank', '2023-01-06 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (7, 'PayPal', 'Grace', '2023-01-07 10:00:00', 'New');
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 1, '2023-01-05 10:00:00', 'Billing', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (2, 1, '2023-01-04 10:00:00', 'Shipping', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (3, 1, '2023-01-03 10:00:00', 'Billing', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (5, 1, '2023-01-01 10:00:00', 'Billing', NULL);
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2023-01-05 10:00:00', NULL, 'alice@example.com');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Phone', '2023-01-04 10:00:00', NULL, '555-0102');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Email', '2023-01-03 10:00:00', NULL, 'charlie@example.com');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Phone', '2023-01-02 10:00:00', NULL, '555-0104');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (101, 1, 'Completed', '2023-02-01 12:00:00', 'First order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (102, 2, 'Pending', '2023-02-02 12:00:00', 'Second order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (103, 4, 'Cancelled', '2023-02-03 12:00:00', 'Third order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (104, 5, 'Completed', '2023-02-04 12:00:00', 'Fourth order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT payment_method FROM customers ORDER BY payment_method;

/*
Gold Result:
('Amex',)
('Cash',)
('Check',)
('PayPal',)
('Visa',)
*/

-- Prediction Query
SELECT DISTINCT payment_method FROM customers;

/*
Prediction Result:
('Visa',)
('PayPal',)
('Cash',)
('Amex',)
('Check',)
*/