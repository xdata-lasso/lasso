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
-- DATASET 2
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (1, 'John', 'A', 'Zimmer', 'M', 'john.z@example.com', 'johnz', 'pw1', '555-9000', 'Austin', 'TX', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (2, 'John', 'B', 'Adams', 'M', 'john.a8@example.com', 'johna8', 'pw2', '555-8000', 'Dallas', 'TX', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (3, 'John', 'C', 'Adams', 'M', 'john.a1@example.com', 'johna1', 'pw3', '555-1000', 'Houston', 'TX', 'USA');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (4, 'John', 'D', 'Adams', 'M', 'john.a5@example.com', 'johna5', 'pw4', '555-5000', 'El Paso', 'TX', 'USA');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (101, 1, '2023-01-01 08:00:00', 'Acct 101', 'Standard');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (102, 2, '2023-01-02 08:00:00', 'Acct 102', 'Standard');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (103, 3, '2023-01-03 08:00:00', 'Acct 103', 'Standard');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT customer_first_name, customer_last_name, phone_number FROM (SELECT LHS.customer_id AS customer_id, LHS.customer_first_name AS customer_first_name, LHS.customer_middle_initial AS customer_middle_initial, LHS.customer_last_name AS customer_last_name, LHS.gender AS gender, LHS.email_address AS email_address, LHS.login_name AS login_name, LHS.login_password AS login_password, LHS.phone_number AS phone_number, LHS.town_city AS town_city, LHS.state_county_province AS state_county_province, LHS.country AS country, RHS.account_id AS account_id, RHS.date_account_opened AS date_account_opened, RHS.account_name AS account_name, RHS.other_account_details AS other_account_details FROM customers AS LHS INNER JOIN accounts AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_first_name, customer_last_name NULLS LAST, phone_number NULLS LAST;

/*
Gold Result:
('John', 'Adams', '555-1000')
('John', 'Adams', '555-8000')
('John', 'Zimmer', '555-9000')
*/

-- Prediction Query
SELECT DISTINCT T1.customer_first_name, T1.customer_last_name, T1.phone_number FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
('John', 'Zimmer', '555-9000')
('John', 'Adams', '555-8000')
('John', 'Adams', '555-1000')
*/