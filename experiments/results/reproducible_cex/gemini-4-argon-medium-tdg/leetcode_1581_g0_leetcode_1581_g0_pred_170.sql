-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 1);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 0);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, 2, -10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM (SELECT CUSTOMER_ID, COALESCE(AMOUNT, 0) AS AMOUNT FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID) AS T WHERE AMOUNT = 0 GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(1, 2)
*/