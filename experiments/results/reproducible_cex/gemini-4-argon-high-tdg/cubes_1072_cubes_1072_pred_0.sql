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
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (100, 'Alice', 'Smith');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (200, 'Bob', 'Jones');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (300, 'Carol', 'White');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (400, 'Dan', 'Brown');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (500, 'Eve', 'Black');
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (600, 'Frank', 'Green');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (201, 100, '2023-01-01', 'Order 1');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (202, 200, '2023-01-02', 'Order 2');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (301, 201, '2023-01-03');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (302, 201, '2023-01-04');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (303, 201, '2023-01-05');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (304, 201, '2023-01-06');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (305, 202, '2023-01-07');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (20, 200, '2023-01-01', 'Alpha', 'Details 20');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (10, 100, '2023-01-02', 'Zeta', 'Details 10');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (30, 300, '2023-01-03', 'Beta', 'Details 30');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (40, 400, '2023-01-04', 'Gamma', 'Details 40');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (50, 500, '2023-01-05', 'Delta', 'Details 50');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (60, 600, '2023-01-06', 'Epsilon', 'Details 60');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 301, 1001, 'PAYMENT', '2023-02-01', 100.00, 'T1', 'D1');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 302, 1002, 'REFUND', '2023-02-02', 200.00, 'T2', 'D2');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 303, 1003, 'ADJUST', '2023-02-03', 300.00, 'T3', 'D3');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (10, 304, 1004, 'CREDIT', '2023-02-04', 400.00, 'T4', 'D4');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 301, 1005, 'PAYMENT', '2023-02-01', 50.00, 'T5', 'D5');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 302, 1006, 'REFUND', '2023-02-02', 60.00, 'T6', 'D6');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 303, 1007, 'ADJUST', '2023-02-03', 70.00, 'T7', 'D7');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (20, 304, 1008, 'CREDIT', '2023-02-04', 80.00, 'T8', 'D8');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (30, 301, 1009, 'PAYMENT', '2023-02-01', 10.00, 'T9', 'D9');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (30, 302, 1010, 'PAYMENT', '2023-02-02', 20.00, 'T10', 'D10');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (30, 303, 1011, 'PAYMENT', '2023-02-03', 30.00, 'T11', 'D11');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (40, 301, 1012, 'PAYMENT', '2023-02-01', 15.00, 'T12', 'D12');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (40, 302, 1013, 'PAYMENT', '2023-02-02', 25.00, 'T13', 'D13');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (40, 303, 1014, 'PAYMENT', '2023-02-03', 35.00, 'T14', 'D14');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (40, 304, 1015, 'PAYMENT', '2023-02-04', 45.00, 'T15', 'D15');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (40, 305, 1016, 'PAYMENT', '2023-02-05', 55.00, 'T16', 'D16');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (50, 301, 1017, 'PAYMENT', '2023-02-01', 99.00, 'T17', 'D17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, account_name FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.date_account_opened AS date_account_opened, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.n AS n FROM accounts AS LHS INNER JOIN (SELECT * FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) WHERE (n = 4)) AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_id, account_name NULLS LAST;

/*
Gold Result:
(10, 'Zeta')
(20, 'Alpha')
*/

-- Prediction Query
SELECT T1.account_id, T2.account_name FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id HAVING COUNT(*) >= 4;

/*
Prediction Result:
(10, 'Zeta')
(20, 'Alpha')
(40, 'Gamma')
*/