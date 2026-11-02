-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Visits (visit_id, customer_id) VALUES (10, 500);
INSERT INTO Visits (visit_id, customer_id) VALUES (20, 500);
INSERT INTO Visits (visit_id, customer_id) VALUES (30, 600);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(500, 2)
(600, 1)
*/

-- Prediction Query
SELECT V.CUSTOMER_ID, COUNT(DISTINCT V.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V CROSS JOIN TRANSACTIONS AS T WHERE NOT V.VISIT_ID IN (SELECT VISIT_ID FROM TRANSACTIONS) GROUP BY V.CUSTOMER_ID;

/*
Prediction Result:
*/