-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (15, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (15, NULL, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 15, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(A.COUNT_NO_TRANS) AS COUNT_NO_TRANS FROM (SELECT VISITS.VISIT_ID, VISITS.CUSTOMER_ID, SUM(CASE WHEN TRANSACTION_ID IS NULL THEN 0 ELSE 1 END) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID GROUP BY VISITS.VISIT_ID) AS A WHERE COUNT_NO_TRANS = 0 GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(None, 2)
*/