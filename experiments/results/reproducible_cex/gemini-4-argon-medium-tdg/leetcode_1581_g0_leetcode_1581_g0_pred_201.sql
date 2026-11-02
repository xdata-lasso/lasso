-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 1);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 0);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 2, -10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT VISIT_ID, COUNT(TRANSACTION_ID) AS COUNT_TRANS, SUM(AMOUNT) AS TOTAL FROM TRANSACTIONS GROUP BY VISIT_ID) SELECT CUSTOMER_ID, COUNT(COALESCE(CTE.COUNT_TRANS, 0)) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN CTE USING (VISIT_ID) WHERE COALESCE(TOTAL, 0) = 0 GROUP BY CUSTOMER_ID ORDER BY 2, CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(1, 2)
*/