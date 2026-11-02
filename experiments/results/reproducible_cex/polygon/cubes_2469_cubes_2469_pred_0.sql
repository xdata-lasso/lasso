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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (11, '-189');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (10, '-189');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (13, 10, '-189');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (12, 10, '-189');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('15', '-189');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('14', '-189');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (17, NULL, NULL, -189, NULL, '-189', NULL);
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (16, '14', NULL, -189, NULL, '-189', '19');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (16, '-189');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (17, '-189');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (17, '-189');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (16, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT investor_id, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT investor_id, other_details, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY investor_id, other_details) ORDER BY investor_id, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
(None, None)
(None, None)
*/

-- Prediction Query
SELECT investor_id, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY investor_id;

/*
Prediction Result:
(None, None)
*/