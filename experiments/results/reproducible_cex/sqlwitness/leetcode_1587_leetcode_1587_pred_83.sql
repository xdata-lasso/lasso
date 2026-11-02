-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10000, NULL), (10001, 'default1'), (9999, 'default2'), (0, 'unique_3'), (1, 'unique_4');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 0, 10000, NULL), (9999, NULL, 10000, '2023-01-02'), (0, 0, 10000, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 20000)
*/

-- Prediction Query
SELECT NAME, AMOUNT AS BALANCE FROM USERS AS U JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS AMOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T ON U.ACCOUNT = T.ACCOUNT;

/*
Prediction Result:
*/