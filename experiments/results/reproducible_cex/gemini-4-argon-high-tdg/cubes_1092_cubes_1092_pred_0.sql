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
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (10, 'Alice', 'A', 'Smith', 'F', 'alice@example.com', 'alices', 'pass1', '555-0101', 'Boston', 'MA', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (20, 'Bob', 'B', 'Jones', 'M', 'bob@example.com', 'bobj', 'pass2', '555-0102', 'Seattle', 'WA', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (30, 'Carol', 'C', 'White', 'F', 'carol@example.com', 'carolw', 'pass3', '555-0103', 'Austin', 'TX', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (40, 'David', 'D', 'Brown', 'M', 'david@example.com', 'davidb', 'pass4', '555-0104', 'Denver', 'CO', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (50, 'Eve', 'E', 'Davis', 'F', 'eve@example.com', 'eved', 'pass5', '555-0105', 'Miami', 'FL', 'USA');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1001, 10, '2022-01-10 09:00:00', 'Checking', 'Primary');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1002, 10, '2022-02-15 10:00:00', 'Savings', 'Secondary');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1003, 10, '2022-03-20 11:00:00', 'Checking', 'Business');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1004, 40, '2022-04-01 12:00:00', 'Standard', 'Personal');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1005, 40, '2022-04-02 13:00:00', 'Standard', 'Personal');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1006, 20, '2022-05-10 14:00:00', 'Main', 'Active');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1007, 30, '2022-06-11 15:00:00', 'Trade', 'Margin');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (1008, 30, '2022-06-12 16:00:00', 'Reserve', 'Hold');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (501, 20, '2022-07-01 10:00:00', 'Order A');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (502, 20, '2022-07-02 10:00:00', 'Order B');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (503, 20, '2022-07-03 10:00:00', 'Order C');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (504, 50, '2022-07-04 10:00:00', 'Order D');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (701, 501, '2022-07-05 10:00:00');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1006, 701, 9001, 'PAYMENT', '2022-07-06 10:00:00', 100.00, 'First', 'Done');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1006, 701, 9002, 'PAYMENT', '2022-07-07 10:00:00', 50.00, 'Second', 'Done');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, customer_id FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) ORDER BY count___, customer_id NULLS LAST;

/*
Gold Result:
(1, 20)
(2, 30)
(2, 40)
(3, 10)
*/

-- Prediction Query
SELECT COUNT(*), customer_id FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(3, 10)
(1, 20)
(2, 30)
(2, 40)
*/