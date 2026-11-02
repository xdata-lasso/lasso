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
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '100 Main St', 'Seattle', '255', 'WA', 'USA', 'Apt 1');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (2, '200 Oak Ave', 'Austin', '255', 'TX', 'USA', 'Suite B');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (3, '300 Pine Rd', 'Seattle', '255', 'WA', 'USA', 'Floor 2');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (4, '400 Elm St', NULL, '255', 'CA', 'USA', 'No city');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (5, '500 Maple Dr', 'Boston', '254', 'MA', 'USA', 'Low zip');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (6, '600 Cedar Ln', 'Denver', '256', 'CO', 'USA', 'High zip');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (7, '700 Birch Blvd', 'Miami', '0255', 'FL', 'USA', 'Leading zero');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (8, '800 Walnut Way', 'Chicago', '2550', 'IL', 'USA', 'Prefix match');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (9, '900 Ash Ct', 'Phoenix', NULL, 'AZ', 'USA', 'Null zip');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (255, '255', '255', '999', '255', '255', '255');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Card', 'Alice Smith', '2022-01-10 10:00:00', 'VIP');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'Bob Jones', '2022-02-15 12:00:00', 'Regular');
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 1, '2022-01-10 10:00:00', 'Home', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (2, 1, '2022-03-01 09:00:00', 'Work', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 5, '2021-01-01 00:00:00', 'Old', '2022-01-09 23:59:59');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM addresses WHERE (zip_postcode = 255) ORDER BY city, addresses.address_id NULLS LAST;

/*
Gold Result:
(None,)
('Austin',)
('Seattle',)
('Seattle',)
*/

-- Prediction Query
SELECT city FROM addresses WHERE zip_postcode = 255;

/*
Prediction Result:
('Seattle',)
('Austin',)
('Seattle',)
(None,)
*/