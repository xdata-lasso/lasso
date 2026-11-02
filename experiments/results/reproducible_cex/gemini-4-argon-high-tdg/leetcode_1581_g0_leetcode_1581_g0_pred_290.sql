-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 20);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (NULL, 1, NULL);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (NULL, 3, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(10, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(A.COUNT_NO_TRANS) AS COUNT_NO_TRANS FROM (SELECT VISITS.VISIT_ID, VISITS.CUSTOMER_ID, SUM(CASE WHEN TRANSACTION_ID IS NULL THEN 0 ELSE 1 END) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID GROUP BY VISITS.VISIT_ID) AS A WHERE COUNT_NO_TRANS = 0 GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(10, 2)
(20, 1)
*/