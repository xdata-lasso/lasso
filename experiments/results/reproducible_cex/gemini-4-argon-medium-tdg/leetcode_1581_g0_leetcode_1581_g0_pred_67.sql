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
SELECT FIN.CUSTOMER_ID, COUNT(FIN.CUSTOMER_ID) AS COUNT_NO_TRANS FROM (SELECT V.CUSTOMER_ID AS CUSTOMER_ID FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID WHERE T.VISIT_ID IS NULL) AS FIN GROUP BY FIN.CUSTOMER_ID ORDER BY COUNT(FIN.CUSTOMER_ID) DESC, FIN.CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(2, 1)
(3, 1)
*/