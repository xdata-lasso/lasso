-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483644, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483643, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483641, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483640, 1);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 2, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 2, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483643, 1, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483642, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483641, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 7)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS USING (VISIT_ID) WHERE AMOUNT IS NULL GROUP BY CUSTOMER_ID ORDER BY COUNT_NO_TRANS DESC, CUSTOMER_ID NULLS LAST;

/*
Prediction Result:
(1, 14)
*/