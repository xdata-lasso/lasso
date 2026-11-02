-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, -664303813);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 2, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 1, 247012447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 1, -1980249628);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 1, -734455130);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, 1744686505);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(-664303813, 1)
(1, 5)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, COUNT(CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS ON VISITS.VISIT_ID = TRANSACTIONS.VISIT_ID WHERE TRANSACTIONS.VISIT_ID IS NULL GROUP BY CUSTOMER_ID ORDER BY COUNT_NO_TRANS DESC, CUSTOMER_ID NULLS LAST;

/*
Prediction Result:
(1, 4)
*/