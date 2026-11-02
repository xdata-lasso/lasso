-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1016, 1017);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1019, 1017);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1020, NULL);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1023, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 2)
(1017, 2)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(A.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS A WHERE NOT A.VISIT_ID IN (SELECT B.VISIT_ID FROM TRANSACTIONS AS B) GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(None, 0)
(1017, 2)
*/