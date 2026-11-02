-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, NULL), (10000, 'default2'), (1, 'default1'), (9999, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 0, 10000, '2023-01-01'), (10001, 0, 0, NULL), (9999, 3, 0, '2023-01-01'), (10000, 10000, 1, NULL), (0, 10001, 9999, NULL), (2, 9999, 10000, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
WITH T1 AS (SELECT T.TRANS_ID, T.ACCOUNT, T.AMOUNT, T.TRANSACTED_ON, U.NAME FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT), T2 AS (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM T1 GROUP BY ACCOUNT) SELECT NAME, BALANCE FROM T2 WHERE BALANCE >= 10000;

/*
Prediction Result:
('unique_4', 10000)
('unique_3', 10000)
*/