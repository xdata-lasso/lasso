-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (0, 1);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 0, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
*/

-- Prediction Query
WITH NEW AS (SELECT V.CUSTOMER_ID, COALESCE(T.VISIT_ID, 0) AS COUNTING FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID) SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM NEW WHERE COUNTING = 0 GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(1, 1)
*/