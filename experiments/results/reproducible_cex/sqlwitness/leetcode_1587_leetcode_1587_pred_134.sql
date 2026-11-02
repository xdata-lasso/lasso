-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, NULL), (10001, 'default2'), (1, 'default1'), (9999, 'unique_3'), (10000, 'unique_4'), (2, 'unique_5');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 9999, NULL, '2023-01-02'), (0, 0, 10001, NULL), (10000, 0, NULL, '2023-01-02'), (1, 1, 10001, NULL), (9999, NULL, 0, '2023-01-01'), (2, NULL, 10001, '2023-01-01'), (3, 10000, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
('default1', 10001)
*/

-- Prediction Query
WITH STEP1 AS (SELECT A.AMOUNT, B.NAME FROM TRANSACTIONS AS A LEFT JOIN USERS AS B ON A.ACCOUNT = B.ACCOUNT) SELECT NAME, SUM(AMOUNT) AS BALANCE FROM STEP1 GROUP BY NAME HAVING SUM(AMOUNT) > 10000;

/*
Prediction Result:
(None, 20002)
('default1', 10001)
*/