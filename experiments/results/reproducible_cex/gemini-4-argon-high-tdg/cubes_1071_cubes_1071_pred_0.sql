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
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (5, 'Alice', 'M', 'Smith', 'F', 'alice@example.com', 'asmith', 'pw1', '555-0101', 'London', 'Greater London', 'UK');
INSERT INTO Customers (customer_id, customer_first_name, customer_middle_initial, customer_last_name, gender, email_address, login_name, login_password, phone_number, town_city, state_county_province, country) VALUES (15, 'Bob', 'J', 'Jones', 'M', 'bob@example.com', 'bjones', 'pw2', '555-0102', 'Manchester', 'Lancashire', 'UK');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (501, NULL, NULL, NULL, NULL);
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (502, NULL, '2023-05-01 00:00:00', 'Unassigned Account', 'Pending owner');
INSERT INTO Accounts (account_id, customer_id, date_account_opened, account_name, other_account_details) VALUES (503, 5, '2023-06-01 12:00:00', 'Alice Main', 'Verified');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, customer_first_name, customer_last_name, n AS count___ FROM (SELECT LHS.customer_id AS customer_id, LHS.n AS n, RHS.customer_first_name AS customer_first_name, RHS.customer_middle_initial AS customer_middle_initial, RHS.customer_last_name AS customer_last_name, RHS.gender AS gender, RHS.email_address AS email_address, RHS.login_name AS login_name, RHS.login_password AS login_password, RHS.phone_number AS phone_number, RHS.town_city AS town_city, RHS.state_county_province AS state_county_province, RHS.country AS country FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) AS LHS LEFT JOIN customers AS RHS ON (LHS.customer_id = RHS.customer_id)) ORDER BY customer_id, customer_first_name NULLS LAST, customer_last_name NULLS LAST, count___ NULLS LAST;

/*
Gold Result:
(None, None, None, 2)
(5, 'Alice', 'Smith', 1)
*/

-- Prediction Query
SELECT T1.customer_id, T2.customer_first_name, T2.customer_last_name, COUNT(*) FROM Accounts AS T1 JOIN Customers AS T2 ON T1.customer_id = T2.customer_id GROUP BY T1.customer_id;

/*
Prediction Result:
(5, 'Alice', 'Smith', 1)
*/