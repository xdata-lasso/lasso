-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (10, 201);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (20, 202);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (30, 203);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (40, 204);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (50, 204);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (100, 10, 0);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (101, 20, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 30, 150);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (102, NULL, 250);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(203, 1)
(204, 2)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(VISIT_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS USING (VISIT_ID) WHERE AMOUNT IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(202, 1)
(204, 2)
*/