-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483648, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483646, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483645, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483641, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483640, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483639, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483638, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483637, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483636, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483635, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483634, 1);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, -2147483646, 600401919);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, -2147483647, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, -2147483645, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, -2147483647, -890215420);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, -2147483639, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 2)
(1, 9)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS NATURAL LEFT JOIN TRANSACTIONS WHERE TRANSACTION_ID IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(None, 3)
(1, 11)
*/