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
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1030, 'result');
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1033, 'push');
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('raise', 'Participant commercial rock clear.');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1031, 'raise', 1030, '1977-08-08', 1032.5, 'hundred', 'expect');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1034, 'raise', 1033, '1978-09-09', 1032.5, 'attorney', 'wish');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1035, 'raise', 1033, '1978-09-09', 1032.5, 'attorney', 'wish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT other_details, transaction_type_code, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY other_details, transaction_type_code) ORDER BY transaction_type_code, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
('raise', 1032.5)
('raise', 1032.5)
*/

-- Prediction Query
SELECT transaction_type_code, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY transaction_type_code;

/*
Prediction Result:
('raise', 1032.5)
*/