-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 1);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (1, NULL, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, SUM(NUM_TRANSACTIONS IS NULL) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN (SELECT COUNT(TRANSACTION_ID) AS NUM_TRANSACTIONS, VISIT_ID FROM TRANSACTIONS GROUP BY VISIT_ID) AS N ON V.VISIT_ID = N.VISIT_ID GROUP BY CUSTOMER_ID HAVING SUM(NUM_TRANSACTIONS IS NULL) > 0;

/*
Prediction Result:
(1, 1)
*/