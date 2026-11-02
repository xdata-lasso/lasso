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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Credit Card', 'Alice Smith', '2023-12-01 00:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'PayPal', 'Bob Jones', '2023-11-01 00:00:00', 'Regular');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Debit Card', 'Charlie Brown', '2023-10-01 00:00:00', 'New');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Cash', 'Diana Prince', '2023-09-01 00:00:00', 'Preferred');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Wire', 'Evan Wright', '2023-08-01 00:00:00', 'Corporate');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Fax', '2021-01-19 08:00:00', '2022-01-02 08:00:00', '555-0119');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Mobile', '2021-01-03 08:00:00', '2022-01-18 08:00:00', '555-0103');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Email', '2021-01-20 08:00:00', '2022-01-01 08:00:00', '555-0120');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Phone', '2021-01-01 08:00:00', '2022-01-20 08:00:00', '555-0101');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Phone', '2021-01-02 08:00:00', '2022-01-19 08:00:00', '555-0101');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Mobile', '2021-01-18 08:00:00', '2022-01-03 08:00:00', '555-0118');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2021-01-05 08:00:00', '2022-01-16 08:00:00', '555-0105');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Fax', '2021-01-04 08:00:00', '2022-01-17 08:00:00', '555-0104');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'SMS', '2021-01-07 08:00:00', '2022-01-14 08:00:00', '555-0107');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Mobile', '2021-01-06 08:00:00', '2022-01-15 08:00:00', '555-0106');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Phone', '2021-01-09 08:00:00', '2022-01-12 08:00:00', '555-0109');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Email', '2021-01-08 08:00:00', '2022-01-13 08:00:00', '555-0108');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Fax', '2021-01-11 08:00:00', '2022-01-10 08:00:00', '555-0111');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'SMS', '2021-01-10 08:00:00', '2022-01-11 08:00:00', '555-0110');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'Email', '2021-01-13 08:00:00', '2022-01-08 08:00:00', '555-0113');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Fax', '2021-01-12 08:00:00', '2022-01-09 08:00:00', '555-0112');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'Phone', '2021-01-15 08:00:00', '2022-01-06 08:00:00', '555-0115');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'Mobile', '2021-01-14 08:00:00', '2022-01-07 08:00:00', '555-0114');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'Phone', '2021-01-17 08:00:00', '2022-01-04 08:00:00', '555-0117');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'SMS', '2021-01-16 08:00:00', '2022-01-05 08:00:00', '555-0116');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code, contact_number FROM (SELECT * FROM (SELECT * FROM customer_contact_channels ORDER BY active_from_date, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST) LIMIT 17);

/*
Gold Result:
('Phone', '555-0101')
('Phone', '555-0101')
('Mobile', '555-0103')
('Fax', '555-0104')
('Email', '555-0105')
('Mobile', '555-0106')
('SMS', '555-0107')
('Email', '555-0108')
('Phone', '555-0109')
('SMS', '555-0110')
('Fax', '555-0111')
('Fax', '555-0112')
('Email', '555-0113')
('Mobile', '555-0114')
('Phone', '555-0115')
('SMS', '555-0116')
('Phone', '555-0117')
*/

-- Prediction Query
SELECT channel_code, contact_number FROM customer_contact_channels WHERE active_to_date - active_from_date = (SELECT active_to_date - active_from_date FROM customer_contact_channels ORDER BY (active_to_date - active_from_date) DESC, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_from_date NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST LIMIT 1);

/*
Prediction Result:
('Fax', '555-0119')
('Mobile', '555-0103')
('Email', '555-0120')
('Phone', '555-0101')
('Phone', '555-0101')
('Mobile', '555-0118')
('Email', '555-0105')
('Fax', '555-0104')
('SMS', '555-0107')
('Mobile', '555-0106')
('Phone', '555-0109')
('Email', '555-0108')
('Fax', '555-0111')
('SMS', '555-0110')
('Email', '555-0113')
('Fax', '555-0112')
('Phone', '555-0115')
('Mobile', '555-0114')
('Phone', '555-0117')
('SMS', '555-0116')
*/