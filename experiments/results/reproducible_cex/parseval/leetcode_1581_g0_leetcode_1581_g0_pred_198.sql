-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, -59984348);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 1, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, -2147483647, 1610062532);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (4, 3, -734455130);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (5, 1, -1633151678);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 3, 1219478689);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH T AS (SELECT CUSTOMER_ID, COUNT(TRANSACTION_ID) AS CNT FROM VISITS LEFT JOIN TRANSACTIONS USING (VISIT_ID) GROUP BY 1, VISIT_ID HAVING COUNT(TRANSACTION_ID) = 0) SELECT CUSTOMER_ID, COUNT(CNT) AS COUNT_NO_TRANS FROM T GROUP BY 1;

/*
Prediction Result:
(1, 2)
*/