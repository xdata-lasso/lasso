-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (16, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (17, 25);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (15, 16, 23);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 17, 24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(25, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(VISIT_ID) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT V.VISIT_ID FROM VISITS AS V JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID) GROUP BY CUSTOMER_ID;

/*
Prediction Result:
*/