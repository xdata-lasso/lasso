-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1011, 1007);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1012, 1007);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1011, 1008);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1013, 1012, 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1007, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS A WHERE NOT VISIT_ID IN (SELECT VISIT_ID FROM TRANSACTIONS AS B WHERE A.VISIT_ID = B.VISIT_ID) GROUP BY CUSTOMER_ID;

/*
Prediction Result:
*/