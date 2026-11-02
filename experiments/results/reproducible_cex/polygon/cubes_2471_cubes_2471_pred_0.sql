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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (13, 'PUR50');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (19, 'PUR50');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (14, 19, 'PUR50');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR16', 'PUR50');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR', 'PUR50');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (18, 'PUR', 19, 20, 50, NULL, 'PUR22');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (17, 'PUR', 19, 21, 906, 'PUR51', 'PUR23');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (17, 'PUR50');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (18, 'PUR50');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (17, 'PUR50');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (17, 'PUR50');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (17, 14);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (17, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "minamount_of_transaction" AS "min_amount_of_transaction_" FROM (SELECT "transaction_id", "investor_id", "transaction_type_code", "date_of_transaction", "amount_of_transaction", "share_count", "other_details", MIN("amount_of_transaction") OVER () AS "minamount_of_transaction" FROM "transactions") WHERE ("transaction_type_code" <> 'PUR' OR minamount_of_transaction <= 50.0) ORDER BY min_amount_of_transaction_;

/*
Gold Result:
(50.0,)
*/

-- Prediction Query
SELECT MIN(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'PUR' AND share_count > 50;

/*
Prediction Result:
(906.0,)
*/