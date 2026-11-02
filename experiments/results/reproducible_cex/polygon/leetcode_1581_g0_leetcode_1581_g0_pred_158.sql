-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (12, 15);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (14, 15);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 14, 22);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(15, 1)
*/

-- Prediction Query
SELECT V.CUSTOMER_ID, COUNT(V.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID WHERE NOT V.VISIT_ID IS NULL AND T.TRANSACTION_ID IS NULL GROUP BY V.CUSTOMER_ID ORDER BY COUNT(V.VISIT_ID) DESC, V.CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(15, 2)
*/