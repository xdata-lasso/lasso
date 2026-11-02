-- Schema DDL
CREATE TABLE "Premises" ("premise_id" INTEGER PRIMARY KEY, "premises_type" TEXT(15), "premise_details" TEXT(255));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "product_name" TEXT(80));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "payment_method" TEXT(15), "customer_name" TEXT(80), "customer_phone" TEXT(80), "customer_email" TEXT(80), "customer_address" TEXT(255), "customer_login" TEXT(80), "customer_password" TEXT(10));

CREATE TABLE "Mailshot_Campaigns" ("mailshot_id" INTEGER PRIMARY KEY, "product_category" TEXT(15), "mailshot_name" TEXT(80), "mailshot_start_date" DATETIME, "mailshot_end_date" DATETIME);

CREATE TABLE "Customer_Addresses" ("customer_id" INTEGER, "premise_id" INTEGER, "date_address_from" DATETIME, "address_type_code" TEXT(15), "date_address_to" DATETIME, FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"), FOREIGN KEY ("premise_id") REFERENCES "Premises" ("premise_id"));

CREATE TABLE "Customer_Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "order_status_code" TEXT(15), "shipping_method_code" TEXT(15), "order_placed_datetime" DATETIME, "order_delivered_datetime" DATETIME, "order_shipping_charges" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Mailshot_Customers" ("mailshot_id" INTEGER, "customer_id" INTEGER, "outcome_code" TEXT(15), "mailshot_customer_date" DATETIME, FOREIGN KEY ("mailshot_id") REFERENCES "Mailshot_Campaigns" ("mailshot_id"), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Order_Items" ("order_id" INTEGER, "product_id" INTEGER, "item_id" INTEGER, "order_item_status_code" TEXT(15), "item_status_code" TEXT(15), "item_delivered_datetime" DATETIME, "item_order_quantity" TEXT(80), FOREIGN KEY ("order_id") REFERENCES "Customer_Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. DISTINCT vs non-DISTINCT (duplicate 'Billing' and 'Residential' codes)
-- 2. ORDER BY ASC vs DESC vs insertion order (unsorted insertion: 'Work', 'Billing', 'Shipping', 'Residential')
-- 3. INNER JOIN traps (Customer_Addresses rows with NULL customer_id or NULL premise_id)
-- 4. RIGHT/FULL JOIN traps (Customers and Premises rows not referenced in Customer_Addresses)
-- 5. Wrong column/table selection (Premises.premises_type and Customers.customer_address have distinct values from address_type_code)
-- 6. Temporal filtering traps (date_address_to in the past, future, or NULL)
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Credit Card', 'Alice Smith', '555-0101', 'alice@example.com', '100 Main St', 'alice', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'PayPal', 'Bob Jones', '555-0102', 'bob@example.com', '200 Oak Ave', 'bob', 'pass2');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (3, 'Debit Card', 'Charlie Brown', '555-0103', 'charlie@example.com', '300 Pine Rd', 'charlie', 'pass3');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (10, 'Commercial', 'Suite 500');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (20, 'House', 'Front Door');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (30, 'Warehouse', 'Loading Dock B');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (1, 10, '2020-01-01 08:00:00', 'Work', '2021-01-01 08:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (1, 20, '2021-01-02 09:00:00', 'Billing', NULL);
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (2, 10, '2019-05-15 10:00:00', 'Billing', '2025-12-31 23:59:59');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (NULL, 20, '2022-03-10 12:00:00', 'Shipping', NULL);
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (2, NULL, '2022-07-20 14:00:00', 'Residential', '2023-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (NULL, NULL, '2023-01-01 00:00:00', 'Residential', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT address_type_code FROM customer_addresses ORDER BY address_type_code;

/*
Gold Result:
('Billing',)
('Residential',)
('Shipping',)
('Work',)
*/

-- Prediction Query
SELECT DISTINCT address_type_code FROM customer_addresses;

/*
Prediction Result:
('Work',)
('Billing',)
('Shipping',)
('Residential',)
*/