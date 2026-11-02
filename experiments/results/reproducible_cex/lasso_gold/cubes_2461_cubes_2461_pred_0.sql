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
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1022, 'l');
INSERT INTO "investors" ("investor_id", "investor_details") VALUES (1026, 'l');
INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (1023, 1022, 'sit');
INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (1025, 1022, 'wait');
INSERT INTO "lots" ("lot_id", "investor_id", "lot_details") VALUES (1027, 1026, 'offer');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lot_details" FROM (SELECT "LHS"."investor_id" AS "investor_id", "LHS"."investor_details" AS "investor_details", "RHS"."lot_id" AS "lot_id", "RHS"."lot_details" AS "lot_details" FROM "investors" AS "LHS" INNER JOIN "lots" AS "RHS" ON ("LHS"."investor_id" = "RHS"."investor_id")) WHERE ("investor_details" = 'l') ORDER BY lot_details, "lot_details" NULLS LAST;

/*
Gold Result:
('offer',)
('sit',)
('wait',)
*/

-- Prediction Query
SELECT T2.lot_details FROM INVESTORS AS T1 JOIN LOTS AS T2 ON T1.investor_id = T2.investor_id WHERE T1.Investor_details = 'l';

/*
Prediction Result:
('sit',)
('wait',)
('offer',)
*/