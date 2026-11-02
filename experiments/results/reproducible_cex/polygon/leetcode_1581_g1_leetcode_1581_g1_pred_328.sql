-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (12, 21);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (14, 12, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 12, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(21, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(VISIT_ID) AS COUNT_NO_TRANS FROM (SELECT VISITS.CUSTOMER_ID AS CUSTOMER_ID, VISITS.VISIT_ID AS VISIT_ID FROM VISITS LEFT JOIN TRANSACTIONS ON TRANSACTIONS.VISIT_ID = VISITS.VISIT_ID GROUP BY VISITS.VISIT_ID HAVING COUNT(TRANSACTION_ID) = 0) AS NO_TRANS_VISITS GROUP BY CUSTOMER_ID;

/*
Prediction Result:
*/