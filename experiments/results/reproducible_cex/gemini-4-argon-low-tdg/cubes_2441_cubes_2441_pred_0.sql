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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Card', 'Bob', '2020-01-02', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Card', 'Charlie', '2020-01-03', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Card', 'David', '2020-01-04', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (5, 'Card', 'Eve', '2020-01-05', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (6, 'Card', 'Frank', '2020-01-06', 'None');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (7, 'Card', 'Grace', '2020-01-07', 'None');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Z_CH', '2020-01-01', '2021-01-01', '111');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'M_CH', '2020-01-01', '2021-01-01', '221');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'M_CH', '2020-01-01', '2021-01-01', '222');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'M_CH', '2020-01-01', '2021-01-01', '223');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'M_CH', '2020-01-01', '2021-01-01', '224');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'A_CH', '2020-01-01', '2021-01-01', '331');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'A_CH', '2020-01-01', '2021-01-01', '332');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'A_CH', '2020-01-01', '2021-01-01', '333');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'A_CH', '2020-01-01', '2021-01-01', '334');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'A_CH', '2020-01-01', '2021-01-01', '335');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'B_CH', '2020-01-01', '2021-01-01', '441');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (2, 'B_CH', '2020-01-01', '2021-01-01', '442');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (3, 'B_CH', '2020-01-01', '2021-01-01', '443');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (4, 'B_CH', '2020-01-01', '2021-01-01', '444');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (5, 'B_CH', '2020-01-01', '2021-01-01', '445');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (6, 'B_CH', '2020-01-01', '2021-01-01', '446');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT channel_code FROM (SELECT channel_code, COUNT(DISTINCT customer_id) AS n_distinct FROM customer_contact_channels GROUP BY channel_code) WHERE (n_distinct <= 5) ORDER BY channel_code;

/*
Gold Result:
('A_CH',)
('M_CH',)
('Z_CH',)
*/

-- Prediction Query
SELECT channel_code FROM customer_contact_channels GROUP BY channel_code HAVING COUNT(customer_id) < 5;

/*
Prediction Result:
('M_CH',)
('Z_CH',)
*/