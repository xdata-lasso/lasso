-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 10
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 10);
INSERT INTO Visits (visit_id, customer_id) VALUES (NULL, 10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(10, 2)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(DISTINCT VISIT_ID) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY 1 ORDER BY 2 DESC, CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(10, 1)
*/