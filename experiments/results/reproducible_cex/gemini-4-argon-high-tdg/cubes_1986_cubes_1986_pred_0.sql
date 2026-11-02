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
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (1, '100 Main St', 'Chicago', '60601', 'Illinois', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (2, '200 Oak Ave', 'Austin', '73301', 'Texas', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (3, '300 Pine Rd', 'Denver', '80201', 'Colorado', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (4, '400 Elm Blvd', 'Austin', '73344', 'Travis', 'USA');
INSERT INTO Addresses (address_id, line_1_number_building, city, zip_postcode, state_province_county, country) VALUES (5, '500 Maple Dr', 'Boston', '02108', 'Massachusetts', 'Canada');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (1, 'CREDIT', 'CUST-001', 'Alice Smith', '999 Billing Way', '555-0101', 'alice@example.com');
INSERT INTO Customers (customer_id, payment_method_code, customer_number, customer_name, customer_address, customer_phone, customer_email) VALUES (2, 'DEBIT', 'CUST-002', 'Bob Jones', '888 Mailing St', '555-0102', 'bob@example.com');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (1, 1, '2020-01-01 00:00:00', '2021-01-01 00:00:00');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (1, 2, '2021-02-01 00:00:00', '2022-01-01 00:00:00');
INSERT INTO Customer_Address_History (address_id, customer_id, date_from, date_to) VALUES (2, 1, '2022-02-01 00:00:00', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT city FROM addresses ORDER BY city, addresses.address_id NULLS LAST;

/*
Gold Result:
('Austin',)
('Austin',)
('Boston',)
('Chicago',)
('Denver',)
*/

-- Prediction Query
SELECT DISTINCT city FROM addresses;

/*
Prediction Result:
('Chicago',)
('Austin',)
('Denver',)
('Boston',)
*/