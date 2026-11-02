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
-- Tests exact boundary conditions around 5 (4, 5, 6), COUNT(DISTINCT customer_id) vs COUNT(*)/COUNT(customer_id) where duplicate customer_ids push total rows > 5 while distinct <= 5, and ORDER BY channel_code vs insertion order or count order.
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2020-01-01', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Card', 'Bob', '2020-01-02', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Cash', 'Charlie', '2020-01-03', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Cash', 'David', '2020-01-04', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Card', 'Eve', '2020-01-05', NULL);
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (6, 'Card', 'Frank', '2020-01-06', NULL);
-- Channel 'CH_SIX': 6 distinct customers (should be excluded)
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'CH_SIX', '2021-01-01', '2022-01-01', '101');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'CH_SIX', '2021-01-01', '2022-01-01', '102');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'CH_SIX', '2021-01-01', '2022-01-01', '103');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'CH_SIX', '2021-01-01', '2022-01-01', '104');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'CH_SIX', '2021-01-01', '2022-01-01', '105');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (6, 'CH_SIX', '2021-01-01', '2022-01-01', '106');
-- Channel 'Z_CH_FIVE': 5 distinct customers, 6 total rows (tests <= 5 boundary and DISTINCT)
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Z_CH_FIVE', '2021-01-01', '2022-01-01', '201');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Z_CH_FIVE', '2022-01-02', '2023-01-01', '201-B');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Z_CH_FIVE', '2021-01-01', '2022-01-01', '202');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Z_CH_FIVE', '2021-01-01', '2022-01-01', '203');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Z_CH_FIVE', '2021-01-01', '2022-01-01', '204');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Z_CH_FIVE', '2021-01-01', '2022-01-01', '205');
-- Channel 'M_CH_ONE_DUP': 1 distinct customer, 6 total rows (tests DISTINCT vs non-distinct count)
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-01-01', '2021-02-01', '301');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-02-02', '2021-03-01', '302');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-03-02', '2021-04-01', '303');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-04-02', '2021-05-01', '304');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-05-02', '2021-06-01', '305');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH_ONE_DUP', '2021-06-02', '2021-07-01', '306');
-- Channel 'A_CH_FOUR': 4 distinct customers (tests < 5 and sorting)
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'A_CH_FOUR', '2021-01-01', '2022-01-01', '401');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'A_CH_FOUR', '2021-01-01', '2022-01-01', '402');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'A_CH_FOUR', '2021-01-01', '2022-01-01', '403');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'A_CH_FOUR', '2021-01-01', '2022-01-01', '404');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code FROM (SELECT channel_code, COUNT(DISTINCT customer_id) AS n_distinct FROM customer_contact_channels GROUP BY channel_code) WHERE (n_distinct <= 5) ORDER BY channel_code;

/*
Gold Result:
('A_CH_FOUR',)
('M_CH_ONE_DUP',)
('Z_CH_FIVE',)
*/

-- Prediction Query
SELECT channel_code FROM customer_contact_channels GROUP BY channel_code HAVING COUNT(customer_id) < 5;

/*
Prediction Result:
('A_CH_FOUR',)
*/