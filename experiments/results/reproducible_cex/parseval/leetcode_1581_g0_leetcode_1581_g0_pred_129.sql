-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483645, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483644, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483643, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 1);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 3, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483648, 1, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483646, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 1, 247012447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, -1980249628);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 5)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, COUNT(*) OVER (PARTITION BY CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS LEFT JOIN TRANSACTIONS USING (VISIT_ID) WHERE TRANSACTION_ID IS NULL;

/*
Prediction Result:
(1, 7)
*/