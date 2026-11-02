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
-- Tests INNER JOIN vs LEFT/RIGHT/FULL OUTER JOIN, duplicate preservation (SELECT vs SELECT DISTINCT), and primary/secondary ORDER BY sorting.
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (1, 'Residential', '101 Main St');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (2, 'Commercial', '202 Market St');
INSERT INTO Premises (premise_id, premises_type, premise_details) VALUES (3, 'Industrial', '303 Factory Rd');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (10, 'Credit', 'Alice', '555-0101', 'alice@example.com', '101 Main St', 'alice1', 'pass1');
INSERT INTO Customers (customer_id, payment_method, customer_name, customer_phone, customer_email, customer_address, customer_login, customer_password) VALUES (20, 'Debit', 'Bob', '555-0102', 'bob@example.com', '202 Market St', 'bob2', 'pass2');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (10, 1, '2022-01-01 00:00:00', 'Shipping', '2023-01-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (20, 1, '2022-05-01 00:00:00', 'Billing', '2023-05-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (10, 1, '2023-01-02 00:00:00', 'Billing', '2023-12-31 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (10, 2, '2022-02-01 00:00:00', 'Shipping', '2023-02-01 00:00:00');
INSERT INTO Customer_Addresses (customer_id, premise_id, date_address_from, address_type_code, date_address_to) VALUES (20, NULL, '2022-06-01 00:00:00', 'OrphanType', '2023-06-01 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT premises_type, address_type_code FROM (SELECT LHS.premise_id AS premise_id, LHS.premises_type AS premises_type, LHS.premise_details AS premise_details, RHS.customer_id AS customer_id, RHS.date_address_from AS date_address_from, RHS.address_type_code AS address_type_code, RHS.date_address_to AS date_address_to FROM premises AS LHS INNER JOIN customer_addresses AS RHS ON (LHS.premise_id = RHS.premise_id)) ORDER BY premises_type, address_type_code NULLS LAST;

/*
Gold Result:
('Commercial', 'Shipping')
('Residential', 'Billing')
('Residential', 'Billing')
('Residential', 'Shipping')
*/

-- Prediction Query
SELECT T2.premises_type, T1.address_type_code FROM customer_addresses AS T1 JOIN premises AS T2 ON T1.premise_id = T2.premise_id;

/*
Prediction Result:
('Residential', 'Shipping')
('Residential', 'Billing')
('Residential', 'Billing')
('Commercial', 'Shipping')
*/