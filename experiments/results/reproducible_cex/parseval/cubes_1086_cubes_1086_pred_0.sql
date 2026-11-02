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
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -921145356, 'fin_165ec2', '2023-01-16 20:10:41+00:00', 0.0001, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1726781632, 'fin_165ec2', '2021-06-17 14:22:38+00:00', 0.0002, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -106629402, 'fin_165ec2', '2020-11-05 04:59:51+00:00', 0.0003, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1865039888, 'fin_165ec2', '2025-06-13 15:31:02+00:00', 0.0004, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -252690330, 'fin_165ec2', '2022-01-21 14:23:36+00:00', 0.0005, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1465859724, 'fin_165ec2', '2022-07-05 02:28:20+00:00', 0.0006, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1908028688, 'fin_e52bf2', '2020-03-08 22:40:47+00:00', 0.0007, 'fin_00cdea', NULL);

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1659388584, 'fin_165ec2', '2020-06-20 11:35:06+00:00', NULL, 'fin_00cdea', NULL);

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -841692980, 'fin_165ec2', '2021-07-20 10:41:36+00:00', NULL, 'fin_00cdea', NULL);

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 462974032, 'fin_165ec2', '2021-12-31 07:20:26+00:00', NULL, 'fin_00cdea', NULL);

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1576219117, NULL, '2020-08-22 06:30:10+00:00', 0.0011, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1861536320, NULL, '2022-12-10 02:38:39+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1620389964, NULL, '2025-05-02 19:47:39+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 1990080517, NULL, '2024-03-03 15:52:53+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 374105386, 'fin_165ec2', '2020-05-12 00:10:04+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1833165707, 'fin_165ec2', '2024-05-26 02:52:16+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -761141909, 'fin_165ec2', '2024-10-24 14:16:53+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -443340271, 'fin_165ec2', '2025-10-02 08:51:14+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 902887186, 'fin_165ec2', '2025-10-19 18:29:54+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -1031969798, 'fin_165ec2', '2022-01-22 16:14:13+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 902551284, 'fin_165ec2', '2020-03-11 14:09:37+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, 743312762, 'fin_165ec2', '2024-11-25 22:27:17+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483648, -2147483648, -868774469, 'fin_165ec2', '2021-03-04 19:22:02+00:00', NULL, 'fin_00cdea', 'fin_8a82dd');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type, sumtransaction_amount AS sum_transaction_amount_ FROM (SELECT other_transaction_details, transaction_type, SUM(transaction_amount) AS sumtransaction_amount FROM financial_transactions GROUP BY other_transaction_details, transaction_type) ORDER BY transaction_type, sum_transaction_amount_ NULLS LAST;

/*
Gold Result:
(None, 0.0011)
(None, None)
('fin_165ec2', 0.0021)
('fin_165ec2', None)
('fin_e52bf2', 0.0007)
*/

-- Prediction Query
SELECT transaction_type, SUM(transaction_amount) FROM Financial_transactions GROUP BY transaction_type;

/*
Prediction Result:
(None, 0.0011)
('fin_165ec2', 0.0021)
('fin_e52bf2', 0.0007)
*/