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

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, -59984348);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483641, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483640, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483639, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483638, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483637, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483636, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483635, 1);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 2, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 2, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 5, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483643, 5, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483642, 5, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483641, 5, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, 1);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483638, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483637, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483636, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483635, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483634, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483633, 1, 11293);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483632, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483631, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(1, 10)
*/

-- Prediction Query
SELECT VISITS.CUSTOMER_ID, SUM(CASE WHEN TRANSACTIONS.AMOUNT IS NULL THEN 1 ELSE 0 END) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID GROUP BY VISITS.CUSTOMER_ID HAVING COUNT_NO_TRANS > 0;

/*
Prediction Result:
(None, 1)
(1, 18)
*/