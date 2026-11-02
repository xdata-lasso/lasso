-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Visits (visit_id, customer_id) VALUES (1, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (2, 1);
INSERT INTO Visits (visit_id, customer_id) VALUES (3, 2);
INSERT INTO Visits (visit_id, customer_id) VALUES (NULL, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1, 2)
(2, 1)
(3, 0)
*/

-- Prediction Query
SELECT VI.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS VI LEFT JOIN TRANSACTIONS AS T ON VI.VISIT_ID = T.VISIT_ID WHERE TRANSACTION_ID IS NULL GROUP BY VI.CUSTOMER_ID ORDER BY COUNT_NO_TRANS, VI.CUSTOMER_ID NULLS LAST;

/*
Prediction Result:
(2, 1)
(3, 1)
(1, 2)
*/