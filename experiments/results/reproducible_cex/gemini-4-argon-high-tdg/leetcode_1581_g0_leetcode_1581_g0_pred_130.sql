-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 7
INSERT INTO Visits (visit_id, customer_id) VALUES (1, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, NULL);
INSERT INTO Visits (visit_id, customer_id) VALUES (4, 10);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (101, 3, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 2)
(10, 1)
*/

-- Prediction Query
SELECT DISTINCT (CUSTOMER_ID), COUNT(CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT (VISIT_ID) FROM TRANSACTIONS) GROUP BY CUSTOMER_ID ORDER BY COUNT(CUSTOMER_ID), (CUSTOMER_ID) NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(None, 0)
(10, 1)
*/