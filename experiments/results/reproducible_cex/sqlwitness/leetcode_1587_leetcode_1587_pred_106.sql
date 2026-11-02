-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, NULL), (9999, 'default1'), (1, 'default2'), (10000, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 10000, 10000, NULL), (0, 0, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
*/

-- Prediction Query
SELECT SUM(T.AMOUNT) AS BALANCE, U.NAME FROM TRANSACTIONS AS T CROSS JOIN USERS AS U WHERE T.ACCOUNT = U.ACCOUNT GROUP BY T.ACCOUNT HAVING SUM(T.AMOUNT) > 10000;

/*
Prediction Result:
(10001, None)
*/