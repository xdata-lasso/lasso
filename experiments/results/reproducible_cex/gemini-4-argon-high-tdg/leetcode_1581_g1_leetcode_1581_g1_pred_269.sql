-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Visits (visit_id, customer_id) VALUES (10, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (20, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (30, 2);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (NULL, 10, 50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (NULL, 10, 60);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (500, 30, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1, 3)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, COUNT(VISITS.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID WHERE TRANSACTIONS.VISIT_ID IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(1, 1)
*/