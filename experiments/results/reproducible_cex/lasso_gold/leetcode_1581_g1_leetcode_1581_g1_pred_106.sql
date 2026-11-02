-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1069, 1070);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1070);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1079, 1080);
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (NULL, 1080);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1069, 1071);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1069, 1076);
INSERT INTO "transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 1079, 1081);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(1070, 2)
(1080, 1)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(DISTINCT VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T USING (VISIT_ID) WHERE TRANSACTION_ID IS NULL GROUP BY CUSTOMER_ID;

/*
Prediction Result:
(1070, 1)
(1080, 1)
*/