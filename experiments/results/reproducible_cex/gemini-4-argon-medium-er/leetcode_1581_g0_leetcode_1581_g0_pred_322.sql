-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 10);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (1, NULL, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(VISIT_ID) AS COUNT_NO_TRANS FROM (SELECT VISITS.CUSTOMER_ID AS CUSTOMER_ID, VISITS.VISIT_ID AS VISIT_ID FROM VISITS LEFT JOIN TRANSACTIONS ON TRANSACTIONS.VISIT_ID = VISITS.VISIT_ID GROUP BY VISITS.VISIT_ID HAVING COUNT(TRANSACTION_ID) = 0) AS NO_TRANS_VISITS GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(10, 1)
*/