-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (1, 1);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 2);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT CUSTOMER_ID, COUNT(*) - COUNT(T.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN (SELECT DISTINCT (VISIT_ID) FROM TRANSACTIONS) AS T ON T.VISIT_ID = V.VISIT_ID GROUP BY CUSTOMER_ID) AS A WHERE A.COUNT_NO_TRANS > 0;

/*
Prediction Result:
(2, 1)
*/