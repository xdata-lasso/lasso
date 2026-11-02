-- Schema DDL
CREATE TABLE VISITS (VISIT_ID INTEGER PRIMARY KEY, CUSTOMER_ID INTEGER);

CREATE TABLE TRANSACTIONS (TRANSACTION_ID INTEGER PRIMARY KEY, VISIT_ID INTEGER, AMOUNT INTEGER, FOREIGN KEY (VISIT_ID) REFERENCES VISITS (VISIT_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: visits --
INSERT INTO "visits" ("visit_id", "customer_id") VALUES (1, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (2, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (3, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (4, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (5, 1);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (6, -55602865);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (-2147483642, 2);

INSERT INTO "visits" ("visit_id", "customer_id") VALUES (7, NULL);
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
SELECT V.CUSTOMER_ID, COUNT(V.CUSTOMER_ID) AS COUNT_NO_TRANS FROM VISITS AS V LEFT JOIN TRANSACTIONS AS T ON V.VISIT_ID = T.VISIT_ID WHERE T.TRANSACTION_ID IS NULL GROUP BY V.CUSTOMER_ID;

/*
Prediction Result:
(None, 0)
(-55602865, 1)
(1, 5)
(2, 1)
*/