-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 100);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (10, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
*/

-- Prediction Query
WITH TRAN_PER_VISIT AS (SELECT VISIT_ID, SUM(AMOUNT) AS TOTAL_AMOUNT FROM TRANSACTIONS GROUP BY VISIT_ID), VISITS_TRANS AS (SELECT A.*, B.TOTAL_AMOUNT FROM VISITS AS A LEFT JOIN TRAN_PER_VISIT AS B ON A.VISIT_ID = B.VISIT_ID) SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS_TRANS WHERE TOTAL_AMOUNT IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(100, 1)
*/