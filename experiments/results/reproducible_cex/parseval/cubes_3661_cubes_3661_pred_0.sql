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
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (1, -2147483648, '2024-02-19 01:18:26+00:00');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (-2147483648, -2147483648, '2024-12-15 00:56:33+00:00', 'acc_cebcf7', 'acc_f54433');

-- Inserting into table: financial_transactions --
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -921145356, 'fin_fd4fbd', '2023-01-16 20:10:41+00:00', 0.0001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1981402255, 'fin_fd4fbd', '2022-06-28 11:34:24+00:00', 0.0002, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1610062532, 'fin_fd4fbd', '2024-01-16 07:29:50+00:00', 0.0003, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1871297066, 'fin_fd4fbd', '2025-11-08 19:01:33+00:00', 0.0004, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 89267185, 'fin_fd4fbd', '2020-09-25 19:25:33+00:00', 0.0005, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1633151678, 'fin_fd4fbd', '2021-02-21 20:09:01+00:00', 0.0006, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1268590800, NULL, '2023-03-21 21:13:18+00:00', 0.0007, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1670923962, NULL, '2025-08-22 00:34:24+00:00', 0.0008, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 906324270, NULL, '2020-04-05 14:43:51+00:00', 0.0009, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 13244799, 'fin_fd4fbd', '2022-09-23 20:24:07+00:00', 0.001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1526238907, 'fin_fd4fbd', '2021-07-11 07:27:32+00:00', 0.0011, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1610064545, 'fin_fd4fbd', '2020-03-11 00:23:16+00:00', 0.0012, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 462974032, 'fin_fd4fbd', '2021-12-31 07:20:26+00:00', 0.0013, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -918961358, 'fin_fd4fbd', '2021-01-29 03:06:29+00:00', 0.0014, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -45536098, 'fin_fd4fbd', '2021-11-09 05:42:50+00:00', 0.0015, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1399556171, 'fin_fd4fbd', '2020-01-18 08:28:25+00:00', 0.0016, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 546571701, 'fin_fd4fbd', '2024-10-26 11:04:11+00:00', 0.0017, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1990080517, 'fin_fd4fbd', '2024-03-03 15:52:53+00:00', 0.0018, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 700088193, 'fin_fd4fbd', '2024-12-29 01:35:14+00:00', 0.0019, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, 1274489983, 'fin_fd4fbd', '2021-02-04 01:21:18+00:00', 0.002, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, 1, -1833165707, 'fin_fd4fbd', '2024-05-26 02:52:16+00:00', 0.0021, 'fin_00cdea', 'fin_1d8ec2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS account_id FROM (SELECT COUNT(*) AS n FROM (SELECT invoice_number, MAX(n) AS maxn FROM (SELECT invoice_number, transaction_type, COUNT(*) AS n FROM financial_transactions GROUP BY invoice_number, transaction_type) GROUP BY invoice_number)) ORDER BY account_id;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT account_id FROM Financial_transactions GROUP BY account_id ORDER BY COUNT(*) DESC, account_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(-2147483648,)
*/