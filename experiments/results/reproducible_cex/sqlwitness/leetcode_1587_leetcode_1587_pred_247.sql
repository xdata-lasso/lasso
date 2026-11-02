-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default1'), (9999, NULL), (10001, 'default2'), (10000, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 10000, 10000, '2023-01-02'), (10000, 10001, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 10001)
*/

-- Prediction Query
SELECT (SELECT NAME FROM USERS AS U WHERE T.ACCOUNT = U.ACCOUNT) AS NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T GROUP BY T.ACCOUNT HAVING SUM(AMOUNT) >= 10000;

/*
Prediction Result:
('unique_3', 10000)
('default2', 10001)
*/