-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1020, 1021);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1021);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1025, NULL);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1030, NULL);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1020, 1022);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1025, 1027);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1030, 1031);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 2)
(1021, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT V.VISIT_ID FROM VISITS AS V JOIN TRANSACTIONS AS T ON VISITS.VISIT_ID = T.VISIT_ID GROUP BY CUSTOMER_ID) GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(None, 3)
(1021, 1)
*/