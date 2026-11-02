-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 3);
INSERT INTO Visits (visit_id, customer_id) VALUES (5, 3);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (101, 1, 0);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (102, 3, -50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (103, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 1)
(3, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN TRANSACTIONS AS B ON A.VISIT_ID = B.VISIT_ID WHERE B.AMOUNT IS NULL GROUP BY 1;

/*
Prediction Result:
(1, 1)
(3, 2)
*/