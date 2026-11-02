-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, 'default1');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, NULL, 9999, '2023-01-02'), (1, NULL, 1, '2023-01-02'), (10001, NULL, 1, '2023-01-02'), (9999, 10001, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT (SELECT NAME FROM USERS WHERE ACCOUNT = T.ACCOUNT) AS NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T GROUP BY NAME HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
*/