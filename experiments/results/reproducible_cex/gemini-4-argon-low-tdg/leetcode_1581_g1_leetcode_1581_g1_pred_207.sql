-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 100);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 200);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (NULL, 1, 50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (10, 2, NULL);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (11, NULL, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(100, 1)
*/

-- Prediction Query
WITH T AS (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS), T1 AS (SELECT *, CASE WHEN VISIT_ID IN (SELECT VISIT_ID FROM T) THEN 0 ELSE 1 END AS IF_NO_TRANS FROM VISITS) SELECT CUSTOMER_ID, SUM(IF_NO_TRANS) AS COUNT_NO_TRANS FROM T1 GROUP BY 1 HAVING SUM(IF_NO_TRANS) > 0;

/*
Prediction Result:
*/