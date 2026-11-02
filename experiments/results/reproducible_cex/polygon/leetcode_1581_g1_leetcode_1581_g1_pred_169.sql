-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (29, 35);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, 35);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 29, NULL);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (35, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(35, 1)
*/

-- Prediction Query
WITH VISIT_T AS (SELECT VISIT_ID, SUM(AMOUNT) AS TOTAL FROM TRANSACTIONS GROUP BY VISIT_ID), VISIT_C AS (SELECT V.VISIT_ID, V.CUSTOMER_ID, VT.TOTAL FROM VISITS AS V LEFT JOIN VISIT_T AS VT ON V.VISIT_ID = VT.VISIT_ID) SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISIT_C AS VC WHERE VC.TOTAL IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(35, 2)
*/