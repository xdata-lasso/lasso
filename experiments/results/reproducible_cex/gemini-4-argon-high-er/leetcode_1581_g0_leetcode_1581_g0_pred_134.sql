-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 100);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 200);
INSERT INTO Visits (visit_id, customer_id) VALUES (NULL, 300);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (1, 1, 50);
INSERT INTO Transactions (transaction_id, visit_id, amount) VALUES (2, NULL, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT V.CUSTOMER_ID AS CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID WHERE T.VISIT_ID IS NULL GROUP BY V.CUSTOMER_ID ORDER BY COUNT_NO_TRANS DESC, CUSTOMER_ID NULLS LAST;

/*
Prediction Result:
(200, 1)
(300, 1)
*/