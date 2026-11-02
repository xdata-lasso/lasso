-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers_cards --
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1, 1, 'cus_af32ae', 'cus_972b6c', '2024-12-15 00:56:33+00:00', '2024-06-15 00:00:00+00:00', 'cus_a1268e');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (-2147483647, 1, 'cus_e25785', 'cus_fc65ff', '2025-11-23 07:28:46+00:00', '2024-06-15 00:00:00+00:00', 'cus_d66ec3');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (-2147483646, -55602865, 'q_2_6ebacd', 'cus_6b9283', '2024-02-19 01:18:26+00:00', '2022-06-06 02:35:43+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (-2147483645, -664303813, 'q_2_6ebacd', 'cus_6b9283', '2022-03-24 16:30:12+00:00', '2020-04-30 03:21:27+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (2, -1726781632, 'cus_a1d01c', 'cus_6b9283', '2021-06-17 14:22:38+00:00', '2024-11-14 12:35:58+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (3, 247012447, 'cus_a1d01c', 'cus_6b9283', '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (4, 1610062532, 'cus_a1d01c', 'cus_6b9283', '2024-01-16 07:29:50+00:00', '2022-02-14 19:27:39+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (5, 1871297066, 'cus_a1d01c', 'cus_6b9283', '2025-11-08 19:01:33+00:00', '2022-09-05 02:10:50+00:00', 'cus_3972f8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT card_type_code FROM (SELECT card_type_code, date_valid_to, COUNT(*) AS n FROM (SELECT customer_id AS card_id, customer_id, card_type_code, card_number, date_valid_from, date_valid_to, other_card_details, customer_id_other, card_type_code_other, card_number_other, date_valid_to_other, other_card_details_other FROM (SELECT LHS.card_id AS card_id, LHS.customer_id AS customer_id, LHS.card_type_code AS card_type_code, LHS.card_number AS card_number, LHS.date_valid_from AS date_valid_from, LHS.date_valid_to AS date_valid_to, LHS.other_card_details AS other_card_details, RHS.customer_id AS customer_id_other, RHS.card_type_code AS card_type_code_other, RHS.card_number AS card_number_other, RHS.date_valid_to AS date_valid_to_other, RHS.other_card_details AS other_card_details_other FROM customers_cards AS LHS INNER JOIN customers_cards AS RHS ON (LHS.customer_id = RHS.card_id AND LHS.date_valid_from = RHS.date_valid_from))) GROUP BY card_type_code, date_valid_to) ORDER BY card_type_code;

/*
Gold Result:
('cus_af32ae',)
*/

-- Prediction Query
SELECT card_type_code FROM Customers_cards GROUP BY card_type_code ORDER BY COUNT(*) DESC, card_type_code NULLS LAST LIMIT 1;

/*
Prediction Result:
('cus_a1d01c',)
*/