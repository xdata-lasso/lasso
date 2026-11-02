-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483646, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, -664303813);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483641, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483640, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483639, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483638, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483637, NULL);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(-664303813, 1)
(1, 10)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(CUSTOMER_ID) - COUNT(TRANSACTION_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID GROUP BY CUSTOMER_ID HAVING COUNT(TRANSACTION_ID) < COUNT(CUSTOMER_ID);

/*
Prediction Result:
(-664303813, 1)
(1, 10)
*/