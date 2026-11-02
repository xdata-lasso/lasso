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
INSERT INTO Customers (customer_id, customer_first_name, customer_last_name) VALUES (1, 'Alice', 'Smith');
INSERT INTO Orders (order_id, customer_id, date_order_placed, order_details) VALUES (1, 1, '2023-01-01 10:00:00', 'Initial Order');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name) VALUES (1, 1, '2023-01-01 09:00:00', 'Main Account');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (10, 1, '2023-01-02 10:00:00');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (20, 1, '2023-01-03 10:00:00');
INSERT INTO Invoices (invoice_number, order_id, invoice_date) VALUES (30, 1, '2023-01-04 10:00:00');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 1, 'Pay', '2023-01-05 10:00:00', 100.0, 'Alpha', 'D1');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 2, 'Pay', '2023-01-05 11:00:00', 100.0, 'Alpha', 'D2');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 3, 'Pay', '2023-01-05 12:00:00', 100.0, 'Alpha', 'D3');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 4, 'Ref', '2023-01-05 13:00:00', 50.0, 'Beta', 'D4');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 5, 'Pay', '2023-01-05 14:00:00', 75.0, 'Gamma', 'D5');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 20, 6, 'Pay', '2023-01-05 15:00:00', 75.0, 'Gamma', 'D6');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 7, 'Pay', '2023-01-06 10:00:00', 200.0, 'Alpha', 'D7');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 8, 'Pay', '2023-01-06 11:00:00', 200.0, 'Alpha', 'D8');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 9, 'Pay', '2023-01-06 12:00:00', 300.0, 'Delta', 'D9');
INSERT INTO Financial_Transactions (account_id, invoice_number, transaction_id, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details) VALUES (1, 10, 10, 'Pay', '2023-01-06 13:00:00', 300.0, 'Delta', 'D10');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT invoice_number, n AS count___ FROM (SELECT invoice_number, transaction_comment, COUNT(*) AS n FROM financial_transactions GROUP BY invoice_number, transaction_comment) ORDER BY invoice_number, count___ NULLS LAST;

/*
Gold Result:
(10, 2)
(10, 2)
(20, 1)
(20, 2)
(20, 3)
*/

-- Prediction Query
SELECT invoice_number, COUNT(*) FROM Financial_transactions GROUP BY invoice_number;

/*
Prediction Result:
(10, 4)
(20, 6)
*/