-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (13, 18);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 18);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(18, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, (COUNT(*)) AS COUNT_NO_TRANS FROM VISITS AS V WHERE NOT V.VISIT_ID IN (SELECT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID ORDER BY CUSTOMER_ID, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(18, 2)
*/