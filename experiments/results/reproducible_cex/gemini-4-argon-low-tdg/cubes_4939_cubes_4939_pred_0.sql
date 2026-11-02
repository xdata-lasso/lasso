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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice', '2020-01-01', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'Bob', '2020-01-02', 'None');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C01', '2021-01-01', '2022-01-01', '555-0001');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C02', '2021-01-02', '2022-01-02', '555-0002');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C03', '2021-01-03', '2022-01-03', '555-0003');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C04', '2021-01-04', '2022-01-04', '555-0004');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C05', '2021-01-05', '2022-01-05', '555-0005');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C06', '2021-01-06', '2022-01-06', '555-0006');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C07', '2021-01-07', '2022-01-07', '555-0007');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C08', '2021-01-08', '2022-01-08', '555-0008');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C09', '2021-01-09', '2022-01-09', '555-0009');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C10', '2021-01-10', '2022-01-10', '555-0010');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C11', '2021-01-11', '2022-01-11', '555-0011');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C12', '2021-01-12', '2022-01-12', '555-0012');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C13', '2021-01-13', '2022-01-13', '555-0013');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C14', '2021-01-14', '2022-01-14', '555-0014');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C15', '2021-01-15', '2022-01-15', '555-0015');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C16', '2021-01-16', '2022-01-16', '555-0016');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C17', '2021-01-17', '2022-01-17', '555-0017');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'C18', '2021-01-18', '2022-01-18', '555-0018');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'C19', '2021-01-19', '2022-01-19', '555-0019');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'C20', '2021-01-20', '2022-01-20', '555-0020');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code, contact_number FROM (SELECT * FROM (SELECT * FROM customer_contact_channels ORDER BY active_from_date, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST) LIMIT 17);

/*
Gold Result:
('C01', '555-0001')
('C02', '555-0002')
('C03', '555-0003')
('C04', '555-0004')
('C05', '555-0005')
('C06', '555-0006')
('C07', '555-0007')
('C08', '555-0008')
('C09', '555-0009')
('C10', '555-0010')
('C11', '555-0011')
('C12', '555-0012')
('C13', '555-0013')
('C14', '555-0014')
('C15', '555-0015')
('C16', '555-0016')
('C17', '555-0017')
*/

-- Prediction Query
SELECT channel_code, contact_number FROM customer_contact_channels WHERE active_to_date - active_from_date = (SELECT active_to_date - active_from_date FROM customer_contact_channels ORDER BY (active_to_date - active_from_date) DESC, customer_contact_channels.customer_id NULLS LAST, customer_contact_channels.channel_code NULLS LAST, customer_contact_channels.active_from_date NULLS LAST, customer_contact_channels.active_to_date NULLS LAST, customer_contact_channels.contact_number NULLS LAST LIMIT 1);

/*
Prediction Result:
('C01', '555-0001')
('C02', '555-0002')
('C03', '555-0003')
('C04', '555-0004')
('C05', '555-0005')
('C06', '555-0006')
('C07', '555-0007')
('C08', '555-0008')
('C09', '555-0009')
('C10', '555-0010')
('C11', '555-0011')
('C12', '555-0012')
('C13', '555-0013')
('C14', '555-0014')
('C15', '555-0015')
('C16', '555-0016')
('C17', '555-0017')
('C18', '555-0018')
('C19', '555-0019')
('C20', '555-0020')
*/