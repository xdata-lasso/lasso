-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 3);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (10, 1, 50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (11, NULL, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT TB1.CUSTOMER_ID, COUNT(TB1.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS TB1 LEFT JOIN (SELECT TB3.VISIT_ID, SUM(TB3.AMOUNT) AS AMOUNT FROM TRANSACTIONS AS TB3 GROUP BY TB3.VISIT_ID) AS TB2 ON TB1.VISIT_ID = TB2.VISIT_ID WHERE TB2.AMOUNT IS NULL GROUP BY TB1.CUSTOMER_ID;

/*
Prediction Result:
(2, 1)
(3, 1)
*/