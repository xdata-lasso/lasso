-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (NULL, NULL);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (12, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(13, 1)
*/

-- Prediction Query
SELECT VISITS.CUSTOMER_ID, COUNT(CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN (SELECT DISTINCT TRANSACTIONS.VISIT_ID AS A FROM TRANSACTIONS) AS TMP ON VISITS.VISIT_ID = TMP.A WHERE TMP.A IS NULL GROUP BY VISITS.CUSTOMER_ID;

/*
Prediction Result:
(None, 0)
(13, 1)
*/