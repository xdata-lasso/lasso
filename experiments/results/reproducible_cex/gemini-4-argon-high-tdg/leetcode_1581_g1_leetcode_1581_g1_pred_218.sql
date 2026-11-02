-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Visits (visit_id, customer_id) VALUES (100, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (NULL, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (200, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (300, 20);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 300, 99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(10, 1)
*/

-- Prediction Query
SELECT T.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM (SELECT T1.VISIT_ID, T1.CUSTOMER_ID, T2.TRANSACTION_ID FROM VISITS AS T1 LEFT JOIN TRANSACTIONS AS T2 ON T1.VISIT_ID = T2.VISIT_ID) AS T WHERE T.TRANSACTION_ID IS NULL GROUP BY T.CUSTOMER_ID;

/*
Prediction Result:
(None, 1)
(10, 2)
*/