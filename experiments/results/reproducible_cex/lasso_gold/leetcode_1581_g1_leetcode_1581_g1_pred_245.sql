-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1099, 1100);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1100);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1105, 1106);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1106);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1099, 1101);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1104, 1105, 1107);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, NULL, 1107);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1100, 1)
(1106, 0)
*/

-- Prediction Query
WITH T1 AS (SELECT V.CUSTOMER_ID, COUNT(V.VISIT_ID) - SUM(CASE WHEN NOT T.TRANSACTION_ID IS NULL THEN 1 ELSE 0 END) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID GROUP BY V.CUSTOMER_ID) SELECT * FROM T1 WHERE COUNT_NO_TRANS <> 0;

/*
Prediction Result:
(1100, 1)
*/