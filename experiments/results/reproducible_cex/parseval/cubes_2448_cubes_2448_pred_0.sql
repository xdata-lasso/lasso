-- Schema DDL
CREATE TABLE "Investors" ("investor_id" INTEGER PRIMARY KEY, "Investor_details" TEXT(255));

CREATE TABLE "Lots" ("lot_id" INTEGER PRIMARY KEY, "investor_id" INTEGER, "lot_details" TEXT(255), FOREIGN KEY ("investor_id") REFERENCES "Investors" ("investor_id"));

CREATE TABLE "Ref_Transaction_Types" ("transaction_type_code" TEXT(10) PRIMARY KEY, "transaction_type_description" TEXT(80));

CREATE TABLE "Transactions" ("transaction_id" INTEGER PRIMARY KEY, "transaction_type_code" TEXT(10), "investor_id" INTEGER, "date_of_transaction" DATETIME, "amount_of_transaction" REAL(19, 4), "share_count" TEXT(40), "other_details" TEXT(255), FOREIGN KEY ("transaction_type_code") REFERENCES "Ref_Transaction_Types" ("transaction_type_code"), FOREIGN KEY ("investor_id") REFERENCES "Investors" ("investor_id"));

CREATE TABLE "Sales" ("sales_transaction_id" INTEGER PRIMARY KEY, "sales_details" TEXT(255), FOREIGN KEY ("sales_transaction_id") REFERENCES "Transactions" ("transaction_id"));

CREATE TABLE "Purchases" ("purchase_transaction_id" INTEGER, "purchase_details" TEXT(255), FOREIGN KEY ("purchase_transaction_id") REFERENCES "Transactions" ("transaction_id"));

CREATE TABLE "Transactions_Lots" ("transaction_id" INTEGER, "lot_id" INTEGER, FOREIGN KEY ("transaction_id") REFERENCES "Transactions" ("transaction_id"), FOREIGN KEY ("lot_id") REFERENCES "Lots" ("lot_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483648, 'tra_d36830', -2147483648, '2024-12-15 00:56:33+00:00', 0.0001, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483647, 'tra_d36830', -2147483648, '2021-05-28 17:00:04+00:00', 0.0002, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483646, 'tra_d36830', -2147483648, '2022-06-06 02:35:43+00:00', 0.0003, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483645, 'tra_d36830', -2147483648, '2023-01-16 20:10:41+00:00', 0.0004, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483644, 'tra_d36830', -2147483648, '2020-04-30 03:21:27+00:00', 0.0005, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483643, 'tra_d36830', -2147483648, '2022-06-28 11:34:24+00:00', 0.0006, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483642, 'tra_d36830', -2147483648, '2024-11-14 12:35:58+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483641, 'tra_d36830', -2147483648, '2025-02-21 23:30:13+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483640, 'tra_d36830', -2147483648, '2024-01-16 07:29:50+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483639, 'tra_d36830', -2147483648, '2025-11-08 19:01:33+00:00', 0.001, 'tra_41391c', 'tra_ef0dd5');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483638, 'tra_d36830', -2147483648, '2020-09-25 19:25:33+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483637, 'tra_d36830', -2147483648, '2025-06-13 15:31:02+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483636, 'tra_d36830', -2147483648, '2021-02-21 20:09:01+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483635, 'tra_d36830', -2147483648, '2023-03-21 21:13:18+00:00', 0.0014, 'tra_41391c', NULL);

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483634, 'tra_d36830', -2147483648, '2022-10-06 13:20:05+00:00', NULL, 'tra_41391c', NULL);

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483633, 'tra_d36830', -2147483648, '2020-12-10 17:36:20+00:00', NULL, 'tra_41391c', NULL);

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483632, 'tra_d36830', -2147483648, '2025-08-22 00:34:24+00:00', NULL, 'tra_41391c', NULL);

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483631, 'tra_d36830', -2147483648, '2022-12-20 09:53:17+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483630, 'tra_d36830', -2147483648, '2020-03-08 22:40:47+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483629, 'tra_d36830', -2147483648, '2024-04-12 00:38:47+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483628, 'tra_d36830', -2147483648, '2022-09-23 20:24:07+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483627, 'tra_d36830', -2147483648, '2022-11-06 10:19:41+00:00', NULL, 'tra_41391c', 'tra_14e99b');

INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (-2147483626, 'tra_d36830', -2147483648, '2021-07-11 07:27:32+00:00', NULL, 'tra_41391c', 'tra_14e99b');

-- Inserting into table: investors --
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (-2147483648, 'inv_a898d1');

-- Inserting into table: ref_transaction_types --
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('tra_d36830', 'ref_8ac1c2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanamount_of_transaction" AS "avg_amount_of_transaction_" FROM (SELECT "other_details", "transaction_type_code", AVG("amount_of_transaction") AS "meanamount_of_transaction" FROM "transactions" GROUP BY "other_details", "transaction_type_code") WHERE ("transaction_type_code" = 'SALE') ORDER BY avg_amount_of_transaction_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
(None,)
*/