-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default1'), (10001, 'default2'), (10000, NULL);
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 10000, 10000, NULL), (10000, NULL, 10001, '2023-01-02'), (10001, 1, 10000, '2023-01-01'), (9999, 10001, 1, NULL), (0, 10000, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT (SELECT NAME FROM USERS AS U WHERE T.ACCOUNT = U.ACCOUNT) AS NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS T GROUP BY ACCOUNT HAVING SUM(AMOUNT) > 10000;

/*
Prediction Result:
(None, 10001)
*/