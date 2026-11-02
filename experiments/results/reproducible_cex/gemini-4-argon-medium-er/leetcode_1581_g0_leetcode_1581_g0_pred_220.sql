-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 10);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (100, NULL, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(1) - SUM(IIF(NOT B.VISIT_ID IS NULL, 1, 0)) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN (SELECT VISIT_ID FROM TRANSACTIONS GROUP BY VISIT_ID) AS B ON A.VISIT_ID = B.VISIT_ID GROUP BY A.CUSTOMER_ID HAVING COUNT(1) - SUM(IIF(NOT B.VISIT_ID IS NULL, 1, 0)) > 0;

/*
Prediction Result:
(10, 1)
*/