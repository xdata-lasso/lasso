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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (18, 'SALE');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (12, 'SALE');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (14, 12, 'SALE');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (13, 12, 'SALE');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE15', 'SALE');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'SALE');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (17, 'SALE', 18, 40, NULL, 'SALE41', 'SALE19');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (16, 'SALE', 18, 42, NULL, 'SALE43', 'SALE31');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (16, 'SALE');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (16, 'SALE');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (16, 'SALE');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (17, 14);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (16, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanamount_of_transaction" AS "avg_amount_of_transaction_" FROM (SELECT "other_details", "transaction_type_code", AVG("amount_of_transaction") AS "meanamount_of_transaction" FROM "transactions" GROUP BY "other_details", "transaction_type_code") WHERE ("transaction_type_code" = 'SALE') ORDER BY avg_amount_of_transaction_;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT AVG(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
(None,)
*/