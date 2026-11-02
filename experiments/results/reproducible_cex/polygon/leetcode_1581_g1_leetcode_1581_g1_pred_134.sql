-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 20);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (14, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 14, 21);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (14, NULL, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(20, 0)
*/

-- Prediction Query
SELECT DISTINCT (CUSTOMER_ID), COUNT(VISIT_ID) OVER (PARTITION BY CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT VISIT_ID FROM TRANSACTIONS) ORDER BY 2 DESC, (CUSTOMER_ID) NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
*/