-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers --
INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483648, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483647, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483646, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483645, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483644, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483643, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483642, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', NULL);

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483641, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', NULL);

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483640, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', NULL);

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483639, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483638, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483637, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483636, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483635, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');

INSERT INTO "customers" ("customer_id", "customer_first_name", "customer_last_name", "customer_address", "customer_phone", "customer_email", "other_customer_details") VALUES (-2147483634, 'cus_be634c', 'cus_e77be9', 'cus_6602b7', 'cus_a818b6', 'cus_14971e', 'cus_0b0c36');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT other_customer_details, COUNT(*) AS n FROM customers GROUP BY other_customer_details) ORDER BY count___;

/*
Gold Result:
(3,)
(12,)
*/

-- Prediction Query
SELECT COUNT(*) FROM Customers;

/*
Prediction Result:
(15,)
*/