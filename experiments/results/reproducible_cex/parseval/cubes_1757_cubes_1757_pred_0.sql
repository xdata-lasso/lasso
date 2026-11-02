-- Schema DDL
CREATE TABLE "Accounts" ("account_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "account_name" TEXT(50), "other_account_details" TEXT(255));

CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_first_name" TEXT(20), "customer_last_name" TEXT(20), "customer_address" TEXT(255), "customer_phone" TEXT(255), "customer_email" TEXT(255), "other_customer_details" TEXT(255));

CREATE TABLE "Customers_Cards" ("card_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "card_type_code" TEXT(15), "card_number" TEXT(80), "date_valid_from" DATETIME, "date_valid_to" DATETIME, "other_card_details" TEXT(255));

CREATE TABLE "Financial_Transactions" ("account_id" INTEGER, "card_id" INTEGER, "transaction_id" INTEGER, "previous_transaction_id" INTEGER, "transaction_type" TEXT(15), "transaction_date" DATETIME, "transaction_amount" REAL, "transaction_comment" TEXT(255), "other_transaction_details" TEXT(255), FOREIGN KEY ("account_id") REFERENCES "Accounts" ("account_id"), FOREIGN KEY ("card_id") REFERENCES "Customers_Cards" ("card_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: customers_cards --
INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (1, -55602865, 'cus_a1d01c', '4560596484842', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (2, -59984348, 'cus_a1d01c', '4560596484842', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (3, -664303813, 'cus_a1d01c', '4560596484842', '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (4, -1022641847, 'cus_a1d01c', 'cus_c632f4', '2020-10-31 07:51:16+00:00', '2022-06-28 11:34:24+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (5, 247012447, 'cus_a1d01c', NULL, '2025-02-21 23:30:13+00:00', '2024-07-26 19:47:18+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (6, 1610062532, 'cus_a1d01c', '4560596484842.0', NULL, '2024-01-16 07:29:50+00:00', 'cus_3972f8');

INSERT INTO "customers_cards" ("card_id", "customer_id", "card_type_code", "card_number", "date_valid_from", "date_valid_to", "other_card_details") VALUES (7, -734455130, 'cus_a1d01c', '4560596484842.0', '2020-07-23 07:32:15+00:00', NULL, 'cus_3972f8');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date_valid_from, date_valid_to FROM customers_cards WHERE (card_number = 4560596484842.0) ORDER BY date_valid_from, customers_cards.card_id NULLS LAST;

/*
Gold Result:
(None, '2024-01-16 07:29:50+00:00')
('2020-07-23 07:32:15+00:00', None)
*/

-- Prediction Query
SELECT date_valid_from, date_valid_to FROM Customers_cards WHERE card_number = '4560596484842';

/*
Prediction Result:
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
('2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00')
*/