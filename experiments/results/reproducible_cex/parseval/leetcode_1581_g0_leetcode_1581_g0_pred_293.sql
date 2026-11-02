-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (6, -55602865);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 2);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (7, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(-55602865, 1)
(1, 6)
(2, 1)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, COUNT(C.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS C LEFT JOIN TRANSACTIONS AS T ON C.VISIT_ID = T.VISIT_ID WHERE T.TRANSACTION_ID IS NULL GROUP BY C.CUSTOMER_ID;

/*
Prediction Result:
(None, 1)
(-55602865, 1)
(1, 5)
(2, 1)
*/