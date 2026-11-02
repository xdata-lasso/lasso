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
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1017, 'clearly');
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1020, 'surface');
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('SALE', 'Whatever from behavior benefit suggest.');
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('old', 'Role movie win.');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1018, 'SALE', 1017, '1973-04-04', 1019.5, 'PM', 'everything');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1021, 'SALE', 1020, '1974-05-05', NULL, 'human', 'bar');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "meanamount_of_transaction" AS "avg_amount_of_transaction_" FROM (SELECT "other_details", "transaction_type_code", AVG("amount_of_transaction") AS "meanamount_of_transaction" FROM "transactions" GROUP BY "other_details", "transaction_type_code") WHERE ("transaction_type_code" = 'SALE') ORDER BY avg_amount_of_transaction_;

/*
Gold Result:
(None,)
(1019.5,)
*/

-- Prediction Query
SELECT AVG(amount_of_transaction) FROM TRANSACTIONS WHERE transaction_type_code = 'SALE';

/*
Prediction Result:
(1019.5,)
*/