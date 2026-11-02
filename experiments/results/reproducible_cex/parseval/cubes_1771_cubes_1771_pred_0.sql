-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (4, 2, 'acc_cebcf7', 'acc_f54433');

INSERT INTO "accounts" ("account_id", "customer_id", "account_name", "other_account_details") VALUES (5, 3, 'acc_cebcf7', 'acc_f54433');

-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (1, 'lhs_6fa9d7', 'lhs_d559d9', 'lhs_fd2c62', 'lhs_8e7f12', 'lhs_87ea17', 'lhs_a81080');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483647, 'lhs_ba02de', 'lhs_3ba28c', 'lhs_635838', 'lhs_ea30b8', 'lhs_14c3e9', 'lhs_132f55');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483646, 'q_0_6fbf41', 'q_0_f0d022', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483645, 'q_0_6fbf41', 'q_0_f0d022', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (2, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_b7724f');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (3, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_b7724f');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_first_name, customer_last_name FROM (SELECT * FROM customers AS LHS WHERE NOT EXISTS(SELECT 1 FROM accounts AS RHS WHERE (LHS.customer_id = RHS.customer_id))) ORDER BY customer_first_name, customer_last_name NULLS LAST;

/*
Gold Result:
('lhs_6fa9d7', 'lhs_d559d9')
('lhs_ba02de', 'lhs_3ba28c')
('q_0_6fbf41', 'q_0_f0d022')
('q_0_6fbf41', 'q_0_f0d022')
*/

-- Prediction Query
SELECT customer_first_name, customer_last_name FROM Customers EXCEPT SELECT T1.customer_first_name, T1.customer_last_name FROM Customers AS T1 JOIN Accounts AS T2 ON T1.customer_id = T2.customer_id;

/*
Prediction Result:
('lhs_6fa9d7', 'lhs_d559d9')
('lhs_ba02de', 'lhs_3ba28c')
('q_0_6fbf41', 'q_0_f0d022')
*/