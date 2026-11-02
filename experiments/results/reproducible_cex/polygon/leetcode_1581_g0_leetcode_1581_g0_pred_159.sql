-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (12, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 2)
*/

-- Prediction Query
SELECT V1.CUSTOMER_ID, COUNT(V1.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V1 LEFT JOIN TRANSACTIONS AS T ON V1.VISIT_ID = T.VISIT_ID WHERE TRANSACTION_ID IS NULL GROUP BY V1.CUSTOMER_ID;

/*
Prediction Result:
(None, 1)
*/