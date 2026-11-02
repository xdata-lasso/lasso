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
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (1, 'Credit', 'Zara', '2022-01-10 10:00:00', 'B');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (2, 'Cash', 'Alice', '2023-05-15 08:30:00', 'D');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (3, 'Debit', 'Alice', '2020-03-20 14:15:00', 'A');
INSERT INTO Customers (customer_id, payment_method, customer_name, date_became_customer, other_customer_details) VALUES (4, 'Check', 'Mike', '2021-11-01 19:45:00', 'C');
INSERT INTO Addresses (address_id, address_content, city, zip_postcode, state_province_county, country, other_address_details) VALUES (1, '10 Main St', 'Boston', '02101', 'MA', 'USA', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 1, '2022-01-10 00:00:00', 'Billing', NULL);
INSERT INTO Customer_Addresses (customer_id, address_id, date_address_from, address_type, date_address_to) VALUES (1, 1, '2022-02-01 00:00:00', 'Shipping', NULL);
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Email', '2022-01-10 00:00:00', NULL, '555-0101');
INSERT INTO Customer_Contact_Channels (customer_id, channel_code, active_from_date, active_to_date, contact_number) VALUES (1, 'Cell', '2022-01-10 00:00:00', NULL, '555-0102');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (101, 1, 'Completed', '2022-03-01 12:00:00', 'First Order');
INSERT INTO Customer_Orders (order_id, customer_id, order_status, order_date, order_details) VALUES (102, 1, 'Pending', '2022-04-01 12:00:00', 'Second Order');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_name FROM customers ORDER BY customer_name, customers.customer_id NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Mike',)
('Zara',)
*/

-- Prediction Query
SELECT customer_name FROM customers;

/*
Prediction Result:
('Zara',)
('Alice',)
('Alice',)
('Mike',)
*/