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
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (11, '17');
INSERT INTO "Investors" ("investor_id", "investor_details") VALUES (10, '17');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (13, 10, '17');
INSERT INTO "Lots" ("lot_id", "investor_id", "lot_details") VALUES (12, 10, '17');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('14', '17');
INSERT INTO "Ref_Transaction_Types" ("transaction_type_code", "transaction_type_description") VALUES ('17', '17');
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (16, '17', 11, 17, -554, '17', NULL);
INSERT INTO "Transactions" ("transaction_id", "transaction_type_code", "investor_id", "date_of_transaction", "amount_of_transaction", "share_count", "other_details") VALUES (15, '17', 10, 17, -554, '17', '18');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (15, '17');
INSERT INTO "Sales" ("sales_transaction_id", "sales_details") VALUES (16, '17');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT transaction_type_code, meanamount_of_transaction AS avg_amount_of_transaction_ FROM (SELECT other_details, transaction_type_code, AVG(amount_of_transaction) AS meanamount_of_transaction FROM transactions GROUP BY other_details, transaction_type_code) ORDER BY transaction_type_code, avg_amount_of_transaction_ NULLS LAST;

/*
Gold Result:
('17', -554.0)
('17', -554.0)
*/

-- Prediction Query
SELECT transaction_type_code, AVG(amount_of_transaction) FROM TRANSACTIONS GROUP BY transaction_type_code;

/*
Prediction Result:
('17', -554.0)
*/