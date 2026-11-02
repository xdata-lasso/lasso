-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (19, 20);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 16);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (13, NULL, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (12, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT VISITS.CUSTOMER_ID, COUNT(IIF(TRANSACTIONS.VISIT_ID IS NULL, 1, 0)) OVER (PARTITION BY VISITS.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID WHERE TRANSACTIONS.VISIT_ID IS NULL;

/*
Prediction Result:
(16, 1)
(20, 1)
*/