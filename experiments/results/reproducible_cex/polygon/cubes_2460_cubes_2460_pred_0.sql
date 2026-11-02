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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (17, '23');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (16, '23');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (19, 17, '23');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (18, 16, '23');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('23', NULL);
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('20', '23');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (22, '23', NULL, NULL, NULL, NULL, '32');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (21, '23', NULL, NULL, NULL, NULL, '36');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (22, '23');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (21, '23');
INSERT INTO "Purchases" ("purchase_transaction_id", "purchase_details") VALUES (21, '23');
INSERT INTO "Transactions_Lots" ("transaction_id", "lot_id") VALUES (21, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_description FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.transaction_type_description AS transaction_type_description FROM transactions AS LHS INNER JOIN (SELECT transaction_type_code, transaction_type_description, COUNT(*) OVER () AS n FROM ref_transaction_types) AS RHS ON (LHS.transaction_id = RHS.n AND LHS.transaction_type_code = RHS.transaction_type_code)) ORDER BY transaction_type_description;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.transaction_type_description FROM Ref_Transaction_Types AS T1 JOIN TRANSACTIONS AS T2 ON T1.transaction_type_code = T2.transaction_type_code GROUP BY T1.transaction_type_code ORDER BY COUNT(*) DESC, T1.transaction_type_description NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/