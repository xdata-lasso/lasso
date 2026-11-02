-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, -1022641847);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1115440883);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483643, NULL);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 1, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 5, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 5, 247012447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483643, 5, -1980249628);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483642, 5, -734455130);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, 1744686505);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -1633151678);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483639, 1, -252690330);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483638, 1, 1644814318);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483637, 1, 1465859724);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483636, 1, -1349201381);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483635, 1, 1019800248);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(None, 1)
(1, 3)
(1115440883, 0)
*/

-- Prediction Query
WITH T1 AS (SELECT V.CUSTOMER_ID, COUNT(V.VISIT_ID) - SUM(CASE WHEN NOT T.TRANSACTION_ID IS NULL THEN 1 ELSE 0 END) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID GROUP BY V.CUSTOMER_ID) SELECT * FROM T1 WHERE COUNT_NO_TRANS <> 0;

/*
Prediction Result:
(None, 1)
(1, 3)
*/