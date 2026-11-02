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
SELECT V2.CUSTOMER_ID, COUNT(V2.VISIT_ID) AS COUNT_NO_TRANS FROM (SELECT * FROM VISITS AS V1 WHERE NOT V1.VISIT_ID IN (SELECT T1.VISIT_ID FROM TRANSACTIONS AS T1)) AS V2 GROUP BY V2.CUSTOMER_ID;

/*
Prediction Result:
*/