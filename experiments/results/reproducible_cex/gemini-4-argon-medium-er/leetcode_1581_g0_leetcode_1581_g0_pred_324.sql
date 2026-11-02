-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 10);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (2, 10);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (100, 1, 50);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (101, 2, 60);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT V.VISIT_ID FROM VISITS AS V JOIN TRANSACTIONS AS T ON VISITS.VISIT_ID = T.VISIT_ID GROUP BY CUSTOMER_ID) GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(10, 1)
*/