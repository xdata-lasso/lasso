-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 40);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (15, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (17, 15, 22);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 15, 23);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(40, 0)
*/

-- Prediction Query
SELECT CUSTOMER_ID, SUM(TRANS) AS COUNT_NO_TRANS FROM (SELECT CUSTOMER_ID, COALESCE(TRANSACTION_ID, 1) AS TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON T.VISIT_ID = V.VISIT_ID WHERE T.TRANSACTION_ID IS NULL) AS NO_TRANS GROUP BY 1;

/*
Prediction Result:
(None, 1)
(40, 1)
*/