-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(1, 0)
*/

-- Prediction Query
SELECT VISITS.CUSTOMER_ID, COUNT(VISITS.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN (SELECT T.VISIT_ID, V.CUSTOMER_ID FROM TRANSACTIONS AS T LEFT JOIN VISITS AS V ON V.VISIT_ID = T.VISIT_ID) AS A ON VISITS.VISIT_ID = A.VISIT_ID WHERE A.VISIT_ID IS NULL GROUP BY VISITS.CUSTOMER_ID;

/*
Prediction Result:
(None, 0)
(1, 1)
*/