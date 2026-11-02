-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 20);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (101, 1, 100);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (102, NULL, 200);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT V.CUSTOMER_ID, COUNT(V.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V WHERE NOT EXISTS(SELECT * FROM TRANSACTIONS AS T WHERE V.VISIT_ID = T.VISIT_ID) GROUP BY CUSTOMER_ID ORDER BY COUNT_NO_TRANS DESC, V.CUSTOMER_ID NULLS LAST;

/*
Prediction Result:
(20, 1)
*/