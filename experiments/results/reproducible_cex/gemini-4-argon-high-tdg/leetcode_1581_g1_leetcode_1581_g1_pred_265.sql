-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Visits (visit_id, customer_id) VALUES (10, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (11, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (12, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (13, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (20, 2);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (100, 10, 0);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (101, 11, NULL);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (102, 12, -50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (103, 20, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(A.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN TRANSACTIONS AS B USING (VISIT_ID) WHERE B.AMOUNT IS NULL GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(1, 2)
(2, 1)
*/