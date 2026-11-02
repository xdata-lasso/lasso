-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1027, 1028);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1030, 1028);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1031);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1032, NULL, 1033);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T1.CUSTOMER_ID, COUNT(T1.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS T1 LEFT JOIN TRANSACTIONS AS T2 ON T1.VISIT_ID = T2.VISIT_ID WHERE T2.VISIT_ID IS NULL GROUP BY T1.CUSTOMER_ID;

/*
Prediction Result:
(1028, 2)
(1031, 1)
*/