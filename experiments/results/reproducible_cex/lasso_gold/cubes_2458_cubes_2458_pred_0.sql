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
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1026, 'building');
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1030, 'nice');
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('rest', 'Seem shoulder future fall citizen about reveal.');
INSERT INTO "ref_transaction_types" ("transaction_type_code", "transaction_type_description") VALUES ('why', 'Out major born.');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1027, 'rest', 1026, '1981-01-12', 10001.0, 'serve', 'everyone');
INSERT INTO "transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (1031, 'why', 1030, '1983-03-14', 10001.0, 'him', 'unit');
INSERT INTO "purchases" ("purchase_transaction_id", "purchase_details") VALUES (1027, 'month');
INSERT INTO "purchases" ("purchase_transaction_id", "purchase_details") VALUES (1027, 'win');
INSERT INTO "purchases" ("purchase_transaction_id", "purchase_details") VALUES (1031, 'theory');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT purchase_details FROM (SELECT transaction_id, investor_id, transaction_type_code, date_of_transaction, amount_of_transaction, share_count, other_details, purchase_details, transaction_id AS purchase_transaction_id FROM (SELECT LHS.transaction_id AS transaction_id, LHS.investor_id AS investor_id, LHS.transaction_type_code AS transaction_type_code, LHS.date_of_transaction AS date_of_transaction, LHS.amount_of_transaction AS amount_of_transaction, LHS.share_count AS share_count, LHS.other_details AS other_details, RHS.purchase_details AS purchase_details FROM transactions AS LHS INNER JOIN purchases AS RHS ON (LHS.transaction_id = RHS.purchase_transaction_id))) WHERE (amount_of_transaction > 10000.0) ORDER BY purchase_details;

/*
Gold Result:
('month',)
('theory',)
('win',)
*/

-- Prediction Query
SELECT T1.purchase_details FROM PURCHASES AS T1 JOIN TRANSACTIONS AS T2 ON T1.purchase_transaction_id = T2.transaction_id WHERE T2.amount_of_transaction > 10000;

/*
Prediction Result:
('month',)
('win',)
('theory',)
*/