-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(50), "customer_middle_initial" TEXT(1), "customer_last_name" TEXT(50), "gender" TEXT(1), "email_address" TEXT(255), "login_name" TEXT(80), "login_password" TEXT(20), "phone_number" TEXT(255), "town_city" TEXT(50), "state_county_province" TEXT(50), "country" TEXT(50));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_order_placed" DATETIME, "order_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Invoices" ("invoice_number" INTEGER PRIMARY KEY, "order_id" INTEGER, "invoice_date" DATETIME, FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"));

CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "date_account_opened" DATETIME, "account_name" TEXT(50), "other_account_details" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

CREATE TABLE "Product_Categories" ("production_type_code" TEXT(15) PRIMARY KEY, "product_type_description" TEXT(80), "vat_rating" REAL(19, 4));

CREATE TABLE "Products" ("product_id" INTEGER PRIMARY KEY, "production_type_code" TEXT(15), "parent_product_id" INTEGER, "unit_price" REAL(19, 4), "product_name" TEXT(80), "product_color" TEXT(20), "product_size" TEXT(20), FOREIGN KEY ("production_type_code") REFERENCES "Product_Categories" ("production_type_code"));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "invoice_number" INTEGER, "transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL(19, 4), "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"));

CREATE TABLE "Order_Items" ("order_item_id" INTEGER PRIMARY KEY, "order_id" INTEGER, "product_id" INTEGER, "product_quantity" TEXT(50), "other_order_item_details" TEXT(255), FOREIGN KEY ("order_id") REFERENCES "Orders" ("order_id"), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"));

CREATE TABLE "Invoice_Line_Items" ("product_id" INTEGER, "invoice_number" INTEGER, "order_item_id" INTEGER, "product_title" TEXT(80), "product_quantity" TEXT(50), "product_price" REAL(19, 4), "derived_product_cost" REAL(19, 4), "derived_vat_payable" REAL(19, 4), "derived_total_cost" REAL(19, 4), FOREIGN KEY ("product_id") REFERENCES "Products" ("product_id"), FOREIGN KEY ("invoice_number") REFERENCES "Invoices" ("invoice_number"), FOREIGN KEY ("order_item_id") REFERENCES "Order_Items" ("order_item_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (1, 'Charlie', 'C', 'Brown', 'M', 'charlie@example.com', 'cbrown', 'pass1', '555-0101', 'Austin', 'TX', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (2, 'Alice', 'A', 'Zebra', 'F', 'alicez@example.com', 'azebra', 'pass2', '555-0102', 'Boston', 'MA', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (3, 'Alice', 'B', 'Adams', 'F', 'alicea@example.com', 'aadams', 'pass3', '555-0103', 'Chicago', 'IL', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (4, 'Bob', 'D', 'Smith', 'M', 'bob@example.com', 'bsmith', 'pass4', '555-0104', 'Denver', 'CO', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (5, 'David', 'E', 'Jones', 'M', 'david@example.com', 'djones', 'pass5', '555-0105', 'Miami', 'FL', 'USA');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (4, 1, '2023-01-10 10:00:00', '900', 'Active');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (20, 2, '2023-01-11 10:00:00', '900', 'Active');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (30, 3, '2023-01-12 10:00:00', '900', 'Active');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1, 4, '2023-01-13 10:00:00', '800', 'Inactive');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_first_name AS customer_first_name, LHS.customer_middle_initial AS customer_middle_initial, LHS.customer_last_name AS customer_last_name, LHS.gender AS gender, LHS.email_address AS email_address, LHS.login_name AS login_name, LHS.login_password AS login_password, LHS.phone_number AS phone_number, LHS.town_city AS town_city, LHS.state_county_province AS state_county_province, LHS.country AS country, RHS.account_id AS account_id, RHS.date_account_opened AS date_account_opened, RHS.account_name AS account_name, RHS.other_account_details AS other_account_details FROM customers AS LHS LEFT JOIN accounts AS RHS ON (LHS.customer_id = RHS.customer_id)) WHERE (account_name = 900) ORDER BY customer_first_name, customer_last_name NULLS LAST;

/*
Gold Result:
('Alice', 'Adams')
('Alice', 'Zebra')
('Charlie', 'Brown')
*/

-- Prediction Query
SELECT T2.customer_first_name, T2.customer_last_name FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id WHERE T1.account_name = '900';

/*
Prediction Result:
('Charlie', 'Brown')
('Alice', 'Zebra')
('Alice', 'Adams')
*/