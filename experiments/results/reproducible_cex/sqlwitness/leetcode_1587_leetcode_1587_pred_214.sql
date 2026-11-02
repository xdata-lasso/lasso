-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10000, 'default1'), (9999, 'default2');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, NULL, 1, '2023-01-02'), (10001, NULL, 10001, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
WITH T AS (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT HAVING BALANCE >= 10000) SELECT USERS.NAME, T.BALANCE FROM T LEFT JOIN USERS ON T.ACCOUNT = USERS.ACCOUNT;

/*
Prediction Result:
(None, 10002)
*/