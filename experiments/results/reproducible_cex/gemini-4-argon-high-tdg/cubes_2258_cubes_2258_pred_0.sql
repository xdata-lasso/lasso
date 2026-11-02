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
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (1, 'Office', '300 Pine Rd');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (2, 'Warehouse', '200 Oak Ave');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (3, 'Residence', '100 Main St');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (4, 'Office', '400 Elm St');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (5, 'Residence', '500 Maple Dr');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (6, 'Residence', '600 Cedar Ln');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (1, 'Credit Card', 'Alice Smith', '555-0101', 'alice@example.com', '100 Main St', 'alices', 'pass123');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (2, 'PayPal', 'Bob Jones', '555-0102', 'bob@example.com', '300 Pine Rd', 'bobj', 'pass456');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (1, 3, '2022-01-01 00:00:00', 'Home', '2023-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (2, 1, '2022-06-01 00:00:00', 'Work', NULL);
INSERT INTO Products (product_id, product_category, product_name) VALUES (1, 'Electronics', 'Laptop');
INSERT INTO Mailshot_Campaigns (mailshot_id, product_category, mailshot_name, mailshot_start_date, mailshot_end_date) VALUES (1, 'Electronics', 'Spring Sale', '2023-03-01 00:00:00', '2023-03-31 23:59:59');
INSERT INTO Customer_Orders (order_id, customer_id, order_status_code, shipping_method_code, order_placed_datetime, order_delivered_datetime, order_shipping_charges) VALUES (1, 1, 'Delivered', 'Express', '2023-03-10 10:00:00', '2023-03-12 14:00:00', '15.00');
INSERT INTO Mailshot_Customers (mailshot_id, customer_id, outcome_code, mailshot_customer_date) VALUES (1, 1, 'Ordered', '2023-03-05 09:00:00');
INSERT INTO Order_Items (order_id, product_id, item_id, order_item_status_code, item_status_code, item_delivered_datetime, item_order_quantity) VALUES (1, 1, 1, 'Shipped', 'Good', '2023-03-12 14:00:00', '1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT premises_type FROM premises ORDER BY premises_type;

/*
Gold Result:
('Office',)
('Residence',)
('Warehouse',)
*/

-- Prediction Query
SELECT DISTINCT premises_type FROM premises;

/*
Prediction Result:
('Office',)
('Warehouse',)
('Residence',)
*/