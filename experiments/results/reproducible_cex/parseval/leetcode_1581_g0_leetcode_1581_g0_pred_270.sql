-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483647, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483644, 2);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, -55602865);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, COUNT(*) AS COUNT_NO_TRANS FROM VISITS WHERE NOT VISIT_ID IN (SELECT DISTINCT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Gold Result:
(None, 1)
(-55602865, 1)
(1, 5)
(2, 1)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, COUNT(A.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN TRANSACTIONS AS B ON A.VISIT_ID = B.VISIT_ID WHERE B.TRANSACTION_ID IS NULL GROUP BY A.CUSTOMER_ID;

/*
Prediction Result:
(None, 0)
(-55602865, 1)
(1, 5)
(2, 1)
*/