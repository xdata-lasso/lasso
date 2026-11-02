-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (15, 17);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 15, 23);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (13, 15, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT VI.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS VI LEFT JOIN TRANSACTIONS AS TRN ON VI.VISIT_ID = TRN.VISIT_ID WHERE TRN.TRANSACTION_ID IS NULL GROUP BY 1;

/*
Prediction Result:
(None, 1)
(17, 1)
*/