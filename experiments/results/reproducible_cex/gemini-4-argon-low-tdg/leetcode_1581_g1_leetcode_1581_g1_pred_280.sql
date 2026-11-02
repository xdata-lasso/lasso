-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Visits (visit_id, customer_id) VALUES (1, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (NULL, 50);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(50, 1)
*/

-- Prediction Query
SELECT DISTINCT (CUSTOMER_ID), COUNT(CUSTOMER_ID) OVER (PARTITION BY CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID WHERE TRANSACTION_ID IS NULL;

/*
Prediction Result:
(None, 0)
(50, 2)
*/