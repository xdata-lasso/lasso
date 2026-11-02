-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 22);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (16, NULL, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (15, NULL, 1026);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(22, 0)
*/

-- Prediction Query
WITH CTE AS (SELECT VISIT_ID, COUNT(TRANSACTION_ID) AS COUNT_TRANS, SUM(AMOUNT) AS TOTAL FROM TRANSACTIONS GROUP BY VISIT_ID) SELECT CUSTOMER_ID, COUNT(COALESCE(CTE.COUNT_TRANS, 0)) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN CTE USING (VISIT_ID) WHERE COALESCE(TOTAL, 0) = 0 GROUP BY CUSTOMER_ID ORDER BY 2, CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(22, 1)
*/