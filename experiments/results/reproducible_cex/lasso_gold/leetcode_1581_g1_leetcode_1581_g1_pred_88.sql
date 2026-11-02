-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1001, 1002);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1002);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1001, 1003);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1002, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN TRANSACTIONS AS B USING (VISIT_ID) WHERE TRANSACTION_ID IS NULL GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(1002, 2)
*/