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
-- 1. LIMIT 17 boundary (20 rows total; catches off-by-one LIMIT 16, LIMIT 18, or missing LIMIT).
-- 2. Join vs Single Table mutants (Customer 1 has no orders/addresses; Customer 2 has multiple orders/addresses causing join fan-out; Customer 3 has normal associations; some contact channels have NULL customer_id which inner joins would drop).
-- 3. Duplicate output rows (channels with identical channel_code and contact_number to catch erroneous SELECT DISTINCT).
-- 4. Ascending vs Descending order on active_from_date and tie-breaker columns.
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Credit Card', 'Alice Smith', '2020-01-01 10:00:00', 'No orders or addresses');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'PayPal', 'Bob Jones', '2020-02-01 10:00:00', 'Multiple orders and addresses');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Cash', 'Charlie Brown', '2020-03-01 10:00:00', 'Single order and address');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Debit', 'David White', '2020-04-01 10:00:00', 'No contact channels');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (10, '123 Main St', 'Seattle', '98101', 'WA', 'USA', NULL);
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (20, '456 Oak Ave', 'Portland', '97201', 'OR', 'USA', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (2, 10, '2020-02-01 00:00:00', 'Billing', '2021-02-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (2, 20, '2020-02-01 00:00:00', 'Shipping', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (3, 10, '2020-03-01 00:00:00', 'Home', NULL);
INSERT INTO Products (product_id, product_details) VALUES (100, 'Laptop');
INSERT INTO Products (product_id, product_details) VALUES (200, 'Mouse');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1000, 2, 'Completed', '2021-01-10 12:00:00', 'First order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1001, 2, 'Pending', '2021-01-15 12:00:00', 'Second order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (1002, 3, 'Shipped', '2021-02-10 12:00:00', 'Third order');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1000, 100, '1');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1000, 200, '2');
INSERT INTO Order_Items (order_id, product_id, order_quantity) VALUES (1002, 100, '1');
-- 20 rows in Customer_Contact_Channels with distinct/tied active_from_date
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '111-0001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2021-01-02 00:00:00', '2022-01-02 00:00:00', '111-0001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Phone', '2021-01-03 00:00:00', '2022-01-03 00:00:00', '111-0003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'SMS', '2021-01-04 00:00:00', '2021-06-04 00:00:00', '111-0004');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (NULL, 'Fax', '2021-01-05 00:00:00', '2022-01-05 00:00:00', '111-0005');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Mobile', '2021-01-06 00:00:00', NULL, '111-0006');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Email', '2021-01-07 00:00:00', '2021-01-08 00:00:00', '111-0007');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Phone', '2021-01-08 00:00:00', '2022-01-08 00:00:00', '111-0008');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Pager', '2021-01-09 00:00:00', '2022-01-09 00:00:00', '111-0009');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'SMS', '2021-01-10 00:00:00', '2022-01-10 00:00:00', '111-0010');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Email', '2021-01-11 00:00:00', '2022-01-11 00:00:00', '111-0011');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Fax', '2021-01-12 00:00:00', '2022-01-12 00:00:00', '111-0012');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Mobile', '2021-01-13 00:00:00', '2022-01-13 00:00:00', '111-0013');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Pager', '2021-01-14 00:00:00', '2022-01-14 00:00:00', '111-0014');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Phone', '2021-01-15 00:00:00', '2022-01-15 00:00:00', '111-0015');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Fax', '2021-01-16 00:00:00', '2022-01-16 00:00:00', '111-0016');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Mobile', '2021-01-17 00:00:00', '2022-01-17 00:00:00', '111-0017');
-- Rows 18, 19, 20 (excluded by LIMIT 17)
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'SMS', '2021-01-18 00:00:00', '2022-01-18 00:00:00', '111-0018');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Pager', '2021-01-19 00:00:00', '2022-01-19 00:00:00', '111-0019');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Fax', '2021-01-20 00:00:00', '2022-01-20 00:00:00', '111-0020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code, contact_number FROM (SELECT * FROM (SELECT * FROM customer_contact_channels ORDER BY active_from_date, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST) LIMIT 17);

/*
Gold Result:
('Email', '111-0001')
('Email', '111-0001')
('Phone', '111-0003')
('SMS', '111-0004')
('Fax', '111-0005')
('Mobile', '111-0006')
('Email', '111-0007')
('Phone', '111-0008')
('Pager', '111-0009')
('SMS', '111-0010')
('Email', '111-0011')
('Fax', '111-0012')
('Mobile', '111-0013')
('Pager', '111-0014')
('Phone', '111-0015')
('Fax', '111-0016')
('Mobile', '111-0017')
*/

-- Prediction Query
SELECT channel_code, contact_number FROM customer_contact_channels WHERE active_to_date - active_from_date = (SELECT active_to_date - active_from_date FROM customer_contact_channels ORDER BY (active_to_date - active_from_date) DESC, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_from_date NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST LIMIT 1);

/*
Prediction Result:
('Email', '111-0001')
('Email', '111-0001')
('Phone', '111-0003')
('Fax', '111-0005')
('Phone', '111-0008')
('Pager', '111-0009')
('SMS', '111-0010')
('Email', '111-0011')
('Fax', '111-0012')
('Mobile', '111-0013')
('Pager', '111-0014')
('Phone', '111-0015')
('Fax', '111-0016')
('Mobile', '111-0017')
('SMS', '111-0018')
('Pager', '111-0019')
('Fax', '111-0020')
*/