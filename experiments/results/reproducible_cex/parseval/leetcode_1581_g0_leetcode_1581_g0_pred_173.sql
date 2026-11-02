-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, -55602865);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 3, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 3, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483643, 3, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483642, 3, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483641, 3, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483638, 1, 2);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483637, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 2)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM (SELECT CUSTOMER_ID, COALESCE(AMOUNT, 0) AS AMOUNT FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID) AS T WHERE AMOUNT = 0 GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(1, 3)
*/