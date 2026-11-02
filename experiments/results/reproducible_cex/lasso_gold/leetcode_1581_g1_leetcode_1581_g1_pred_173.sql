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
SELECT V.CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS AS V WHERE NOT EXISTS(SELECT * FROM TRANSACTIONS AS TS WHERE TS.VISIT_ID = V.VISIT_ID) GROUP BY V.CUSTOMER_ID;

/*
Prediction Result:
*/