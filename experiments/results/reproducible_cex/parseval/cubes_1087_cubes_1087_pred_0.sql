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
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (-2147483648, 'cus_be634c', '5', 'cus_e77be9', '2', 'cus_275a9f', 'cus_8c3f2a', 'cus_9a6a78', 'cus_d5f626', 'cus_c3359a', 'cus_eac53e', 'cus_58c31f');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (-2147483648, -2147483648, '2021-05-28 17:00:04+00:00', 'ord_0a08b4');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (-2147483648, -2147483648, '2024-02-19 01:18:26+00:00');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (-2147483648, -2147483648, '2024-12-15 00:56:33+00:00', 'acc_cebcf7', 'acc_f54433');

-- Inserting into table: financial_transactions --
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 'fin_e52bf2', '2022-06-06 02:35:43+00:00', 0.0001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 'fin_e52bf2', '2022-03-24 16:30:12+00:00', 0.0002, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 'fin_e52bf2', '2022-06-28 11:34:24+00:00', 0.0003, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1980249628, 'fin_e52bf2', '2022-02-14 19:27:39+00:00', NULL, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 89267185, 'fin_e52bf2', '2020-09-25 19:25:33+00:00', NULL, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, NULL, 'fin_e52bf2', '2025-06-13 15:31:02+00:00', 0.0006, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, NULL, 'fin_e52bf2', '2021-02-21 20:09:01+00:00', 0.0007, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, NULL, 'fin_e52bf2', '2023-03-21 21:13:18+00:00', NULL, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, NULL, 'fin_e52bf2', '2023-05-25 17:04:36+00:00', NULL, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1, 'fin_e52bf2', '2025-08-22 00:34:24+00:00', 0.001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 906324270, 'fin_e52bf2', '2020-04-05 14:43:51+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1072996612, 'fin_e52bf2', '2024-04-12 00:38:47+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1019800248, 'fin_e52bf2', '2022-11-06 10:19:41+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -845863578, 'fin_e52bf2', '2021-01-23 18:11:33+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 429706943, 'fin_e52bf2', '2022-01-18 15:57:55+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 2087640001, 'fin_e52bf2', '2025-09-01 05:13:03+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 2026480202, 'fin_e52bf2', '2021-02-17 05:47:13+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -45536098, 'fin_e52bf2', '2021-11-09 05:42:50+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1399556171, 'fin_e52bf2', '2020-01-18 08:28:25+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 546571701, 'fin_e52bf2', '2024-10-26 11:04:11+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1408123494, 'fin_e52bf2', '2020-04-28 17:03:46+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1274489983, 'fin_e52bf2', '2021-02-04 01:21:18+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1833165707, 'fin_e52bf2', '2024-05-26 02:52:16+00:00', 0.5, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1313172851, 'fin_e52bf2', '2022-09-29 20:25:58+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 742285925, 'fin_e52bf2', '2020-03-09 02:18:16+00:00', 0.5, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 902887186, 'fin_e52bf2', '2025-10-19 18:29:54+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 418417917, 'fin_e52bf2', '2021-11-17 08:00:56+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 373262291, 'fin_e52bf2', '2023-04-26 07:28:40+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1884179925, 'fin_e52bf2', '2024-04-01 02:40:29+00:00', 0.0, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 328305758, 'fin_e52bf2', '2022-10-06 23:43:31+00:00', -1.0, 'fin_00cdea', 'fin_1d8ec2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT transaction_id_other AS transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.account_id AS account_id, LHS.invoice_number AS invoice_number, LHS.transaction_type AS transaction_type, LHS.transaction_date AS transaction_date, LHS.transaction_amount AS transaction_amount, LHS.transaction_comment AS transaction_comment, LHS.other_transaction_details AS other_transaction_details, LHS.meantransaction_amount AS meantransaction_amount, RHS.transaction_id AS transaction_id_other, RHS.account_id AS account_id_other, RHS.invoice_number AS invoice_number_other, RHS.transaction_type AS transaction_type_other, RHS.transaction_date AS transaction_date_other, RHS.transaction_amount AS transaction_amount_other, RHS.transaction_comment AS transaction_comment_other, RHS.other_transaction_details AS other_transaction_details_other FROM (SELECT transaction_id, account_id, invoice_number, transaction_type, transaction_date, transaction_amount, transaction_comment, other_transaction_details, AVG(transaction_amount) OVER () AS meantransaction_amount FROM financial_transactions) AS LHS CROSS JOIN financial_transactions AS RHS) WHERE (transaction_amount < transaction_amount_other AND meantransaction_amount <= transaction_amount_other) ORDER BY transaction_id;

/*
Gold Result:
(None,)
(-1833165707,)
(-1399556171,)
(1,)
(418417917,)
(429706943,)
(742285925,)
(902887186,)
(906324270,)
(1019800248,)
(1313172851,)
(1408123494,)
(1884179925,)
(2026480202,)
*/

-- Prediction Query
SELECT transaction_id FROM Financial_transactions WHERE transaction_amount > (SELECT AVG(transaction_amount) FROM Financial_transactions);

/*
Prediction Result:
(1,)
(1,)
(1,)
(None,)
(None,)
(1,)
(906324270,)
(1019800248,)
(429706943,)
(2026480202,)
(-1399556171,)
(1408123494,)
(-1833165707,)
(1313172851,)
(742285925,)
(902887186,)
(418417917,)
(1884179925,)
*/