-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483648, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483645, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483644, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, -59984348);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483641, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483640, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483639, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483638, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483637, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483636, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483635, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483634, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, NULL);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483633, NULL);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 2, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 4, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 2, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 2, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 2, 247012447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 2, -1980249628);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 2, -734455130);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 2, 1744686505);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, -1633151678);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(1, 13)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, SUM(CASE WHEN T.TRANSACTION_ID IS NULL THEN 1 ELSE 0 END) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON T.VISIT_ID = V.VISIT_ID WHERE T.TRANSACTION_ID IS NULL GROUP BY 1;

/*
Prediction Result:
(None, 2)
(-59984348, 1)
(1, 14)
*/