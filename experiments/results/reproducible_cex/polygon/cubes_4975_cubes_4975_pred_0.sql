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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (34, 'PUR29');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (36, 'PUR29');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (27, NULL, 'PUR29');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (29, 34, 'PUR35');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('PUR', 'PUR29');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (29, 'PUR', 36, 37, 38, 'PUR100', 'PUR39');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (NULL, NULL);
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (29, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lot_details" FROM (SELECT "lot_id", "investor_id", "lot_details", "investor_id_other", "transaction_type_code", "date_of_transaction", "amount_of_transaction", "share_count", "other_details", "lot_id" AS "transaction_id", "lot_id_other" FROM (SELECT "LHS"."lot_id" AS "lot_id", "LHS"."investor_id" AS "investor_id", "LHS"."lot_details" AS "lot_details", "LHS"."investor_id_other" AS "investor_id_other", "LHS"."transaction_type_code" AS "transaction_type_code", "LHS"."date_of_transaction" AS "date_of_transaction", "LHS"."amount_of_transaction" AS "amount_of_transaction", "LHS"."share_count" AS "share_count", "LHS"."other_details" AS "other_details", "LHS"."transaction_id" AS "transaction_id", "RHS"."lot_id" AS "lot_id_other" FROM (SELECT "lot_id", "investor_id", "lot_details", "investor_id_other", "transaction_type_code", "date_of_transaction", "amount_of_transaction", "share_count", "other_details", "lot_id" AS "transaction_id" FROM (SELECT "LHS"."lot_id" AS "lot_id", "LHS"."investor_id" AS "investor_id", "LHS"."lot_details" AS "lot_details", "RHS"."investor_id" AS "investor_id_other", "RHS"."transaction_type_code" AS "transaction_type_code", "RHS"."date_of_transaction" AS "date_of_transaction", "RHS"."amount_of_transaction" AS "amount_of_transaction", "RHS"."share_count" AS "share_count", "RHS"."other_details" AS "other_details" FROM "lots" AS "LHS" INNER JOIN "transactions" AS "RHS" ON ("LHS"."lot_id" = "RHS"."transaction_id"))) AS "LHS" INNER JOIN "transactions_lots" AS "RHS" ON ("LHS"."lot_id" = "RHS"."transaction_id"))) WHERE ("transaction_type_code" = 'PUR') ORDER BY lot_details, "lot_details" NULLS LAST;

/*
Gold Result:
('PUR35',)
*/

-- Prediction Query
SELECT T1.lot_details FROM LOTS AS T1 JOIN TRANSACTIONS_LOTS AS T2 ON T1.lot_id = T2.transaction_id JOIN TRANSACTIONS AS T3 ON T2.transaction_id = T3.transaction_id WHERE T3.share_count > 100 AND T3.transaction_type_code = 'PUR';

/*
Prediction Result:
('PUR35',)
*/