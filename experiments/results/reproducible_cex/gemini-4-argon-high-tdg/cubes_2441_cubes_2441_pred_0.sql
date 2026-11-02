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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2020-01-01 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'Bob', '2020-02-01 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Card', 'Charlie', '2020-03-01 10:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'PayPal', 'David', '2020-04-01 10:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Card', 'Eve', '2020-05-01 10:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (6, 'Cash', 'Frank', '2020-06-01 10:00:00', 'New');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Postal', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '100-001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Postal', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '100-002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Postal', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '100-003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Mobile', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '200-001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Mobile', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '200-002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-004');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-005');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (6, 'Phone', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '300-006');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Fax', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '400-001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Fax', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '400-002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Fax', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '400-003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Fax', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '400-004');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Fax', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '400-005');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '500-001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Email', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '500-002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Email', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '500-003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Email', '2021-01-01 00:00:00', '2022-01-01 00:00:00', '500-004');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code FROM (SELECT channel_code, COUNT(DISTINCT customer_id) AS n_distinct FROM customer_contact_channels GROUP BY channel_code) WHERE (n_distinct <= 5) ORDER BY channel_code;

/*
Gold Result:
('Email',)
('Fax',)
('Mobile',)
('Postal',)
*/

-- Prediction Query
SELECT channel_code FROM customer_contact_channels GROUP BY channel_code HAVING COUNT(customer_id) < 5;

/*
Prediction Result:
('Email',)
('Mobile',)
('Postal',)
*/