-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, -1437333179);

-- Inserting into table: transactions --
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (1, 1, -55602865);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (3, 1, -59984348);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483647, 1, -664303813);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483645, 1, -1022641847);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483644, 1, -1726781632);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483643, 1, 247012447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483642, 1, -1980249628);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483641, 1, 809183447);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (2, 3, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (4, 2, NULL);

INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (-2147483638, 4, -921145356);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(1, 1)
*/

-- Prediction Query
WITH CTE AS (SELECT VISIT_ID, COUNT(TRANSACTION_ID) AS COUNT_TRANS, SUM(AMOUNT) AS TOTAL FROM TRANSACTIONS GROUP BY VISIT_ID) SELECT CUSTOMER_ID, COUNT(COALESCE(CTE.COUNT_TRANS, 0)) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN CTE USING (VISIT_ID) WHERE COALESCE(TOTAL, 0) = 0 GROUP BY CUSTOMER_ID ORDER BY 2, CUSTOMER_ID NULLS LAST, COUNT_NO_TRANS NULLS LAST;

/*
Prediction Result:
(1, 3)
*/