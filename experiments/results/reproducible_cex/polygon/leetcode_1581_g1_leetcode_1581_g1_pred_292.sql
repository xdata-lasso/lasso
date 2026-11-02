-- Schema DDL
CREATE TABLE "Visits" ("visit_id" INTEGER, "customer_id" INTEGER, UNIQUE ("visit_id"));

CREATE TABLE "Transactions" ("transaction_id" INTEGER, "visit_id" INTEGER, "amount" INTEGER, FOREIGN KEY ("visit_id") REFERENCES "Visits" ("visit_id"), UNIQUE ("transaction_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (16, 35);
INSERT INTO "Visits" ("visit_id", "customer_id") VALUES (34, 35);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (NULL, 16, 22);
INSERT INTO "Transactions" ("transaction_id", "visit_id", "amount") VALUES (35, NULL, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id, COUNT(V.visit_id) AS count_no_trans FROM Visits AS V LEFT JOIN Transactions AS T ON V.visit_id = T.visit_id WHERE T.transaction_id IS NULL GROUP BY customer_id;

/*
Gold Result:
(35, 2)
*/

-- Prediction Query
SELECT CUSTOMER_ID, COUNT(A.VISIT_ID) AS COUNT_NO_TRANS FROM VISITS AS A LEFT JOIN TRANSACTIONS AS B ON A.VISIT_ID = B.VISIT_ID WHERE NOT A.VISIT_ID IN (SELECT VISIT_ID FROM TRANSACTIONS) GROUP BY CUSTOMER_ID;

/*
Prediction Result:
*/