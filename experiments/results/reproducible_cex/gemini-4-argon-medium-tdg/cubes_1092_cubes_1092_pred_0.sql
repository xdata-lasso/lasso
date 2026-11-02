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
-- Tests basic counting, primary ordering by count (inverse to customer_id), secondary ordering by customer_id on ties, and customers with 0 accounts (to catch LEFT JOIN vs Accounts-only queries).
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (1, 'Alice');
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (2, 'Bob');
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (3, 'Charlie');
INSERT INTO "Customers" ("customer_id", "customer_first_name") VALUES (4, 'Diana');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (101, 1, 'Acc1');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (102, 1, 'Acc2');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (103, 1, 'Acc3');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (104, 2, 'Acc4');
INSERT INTO "Accounts" ("account_id", "customer_id", "account_name") VALUES (105, 3, 'Acc5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, customer_id FROM (SELECT customer_id, COUNT(*) AS n FROM accounts GROUP BY customer_id) ORDER BY count___, customer_id NULLS LAST;

/*
Gold Result:
(1, 2)
(1, 3)
(3, 1)
*/

-- Prediction Query
SELECT COUNT(*), customer_id FROM Accounts GROUP BY customer_id;

/*
Prediction Result:
(3, 1)
(1, 2)
(1, 3)
*/