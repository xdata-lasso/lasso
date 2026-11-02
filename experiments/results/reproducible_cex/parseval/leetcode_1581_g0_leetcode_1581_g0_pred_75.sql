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

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483637, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483636, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483635, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483634, 1);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, 247012447);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(-664303813, 1)
(1, 12)
*/

-- Prediction Query
SELECT V.CUSTOMER_ID, SUM(T.TRANSACTION_ID IS NULL) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID GROUP BY CUSTOMER_ID HAVING SUM(T.TRANSACTION_ID IS NULL) > 0;

/*
Prediction Result:
(None, 1)
(-664303813, 1)
(1, 13)
*/