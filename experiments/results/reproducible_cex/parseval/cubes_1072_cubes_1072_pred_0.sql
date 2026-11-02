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
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_middle_initial", "customer_last_name", "gender", "email_address", "login_name", "login_password", "phone_number", "town_city", "state_county_province", "country") VALUES (1, 'cus_be634c', '5', 'cus_e77be9', '2', 'cus_275a9f', 'cus_8c3f2a', 'cus_9a6a78', 'cus_d5f626', 'cus_c3359a', 'cus_eac53e', 'cus_58c31f');

-- Inserting into table: orders --
INSERT INTO "orders" ("order_id", "customer_id", "date_order_placed", "order_details") VALUES (-2147483648, 1, '2021-05-28 17:00:04+00:00', 'ord_0a08b4');

-- Inserting into table: invoices --
INSERT INTO "invoices" ("invoice_number", "order_id", "invoice_date") VALUES (-2147483648, -2147483648, '2024-02-19 01:18:26+00:00');

-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (1, 1, '2024-06-15 00:00:00+00:00', 'lhs_8c66cf', 'lhs_21215e');

INSERT INTO "accounts" ("account_id", "customer_id", "date_account_opened", "account_name", "other_account_details") VALUES (-2147483647, 1, '2024-06-15 00:00:00+00:00', 'lhs_4088c2', 'lhs_3303e6');

-- Inserting into table: financial_transactions --
INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -921145356, 'fin_e52bf2', '2023-01-16 20:10:41+00:00', 0.0001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1981402255, 'fin_e52bf2', '2022-06-28 11:34:24+00:00', 0.0002, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1610062532, 'fin_e52bf2', '2024-01-16 07:29:50+00:00', 0.0003, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1871297066, 'fin_e52bf2', '2025-11-08 19:01:33+00:00', 0.0004, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 89267185, 'fin_e52bf2', '2020-09-25 19:25:33+00:00', 0.0005, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1633151678, 'fin_e52bf2', '2021-02-21 20:09:01+00:00', 0.0006, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1268590800, 'fin_e52bf2', '2023-03-21 21:13:18+00:00', 0.0007, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1670923962, 'fin_e52bf2', '2025-08-22 00:34:24+00:00', 0.0008, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 906324270, 'fin_e52bf2', '2020-04-05 14:43:51+00:00', 0.0009, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1072996612, 'fin_e52bf2', '2024-04-12 00:38:47+00:00', 0.001, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1659388584, 'fin_e52bf2', '2020-06-20 11:35:06+00:00', 0.0011, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -845863578, 'fin_e52bf2', '2021-01-23 18:11:33+00:00', 0.0012, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1257178728, 'fin_e52bf2', '2022-04-12 01:47:28+00:00', 0.0013, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 907682809, 'fin_e52bf2', '2021-12-08 15:32:00+00:00', 0.0014, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1576219117, 'fin_e52bf2', '2020-08-22 06:30:10+00:00', 0.0015, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1209887326, 'fin_e52bf2', '2024-05-04 23:07:19+00:00', 0.0016, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1151980946, 'fin_e52bf2', '2020-09-15 12:11:12+00:00', 0.0017, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 1419861592, 'fin_e52bf2', '2025-08-21 21:00:40+00:00', 0.0018, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (-2147483647, -2147483648, 1274489983, 'fin_e52bf2', '2021-02-04 01:21:18+00:00', 0.0019, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 528680845, 'fin_e52bf2', '2023-12-22 03:17:01+00:00', 0.002, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -761141909, 'fin_e52bf2', '2024-10-24 14:16:53+00:00', 0.0021, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 742285925, 'fin_e52bf2', '2020-03-09 02:18:16+00:00', 0.0022, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1179823637, 'fin_e52bf2', '2021-09-24 11:50:48+00:00', 0.0023, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -967741825, 'fin_e52bf2', '2025-10-15 06:50:58+00:00', 0.0024, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 373262291, 'fin_e52bf2', '2023-04-26 07:28:40+00:00', 0.0025, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -921187550, 'fin_e52bf2', '2020-02-25 10:33:58+00:00', 0.0026, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, 328305758, 'fin_e52bf2', '2022-10-06 23:43:31+00:00', 0.0027, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -1347802441, 'fin_e52bf2', '2022-02-19 15:51:21+00:00', 0.0028, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -314162272, 'fin_e52bf2', '2023-03-22 03:47:49+00:00', 0.0029, 'fin_00cdea', 'fin_1d8ec2');

INSERT INTO "financial_transactions" ("account_id", "invoice_number", "transaction_id", "transaction_type", "transaction_date", "transaction_amount", "transaction_comment", "other_transaction_details") VALUES (1, -2147483648, -188151580, 'fin_e52bf2', '2024-09-13 14:36:04+00:00', 0.003, 'fin_00cdea', 'fin_1d8ec2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT account_id, account_name FROM (SELECT LHS.account_id AS account_id, LHS.customer_id AS customer_id, LHS.date_account_opened AS date_account_opened, LHS.account_name AS account_name, LHS.other_account_details AS other_account_details, RHS.n AS n FROM accounts AS LHS INNER JOIN (SELECT * FROM (SELECT account_id, COUNT(*) AS n FROM financial_transactions GROUP BY account_id) WHERE (n = 4)) AS RHS ON (LHS.account_id = RHS.account_id)) ORDER BY account_id, account_name NULLS LAST;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.account_id, T2.account_name FROM Financial_transactions AS T1 JOIN Accounts AS T2 ON T1.account_id = T2.account_id GROUP BY T1.account_id HAVING COUNT(*) >= 4;

/*
Prediction Result:
(1, 'lhs_8c66cf')
*/