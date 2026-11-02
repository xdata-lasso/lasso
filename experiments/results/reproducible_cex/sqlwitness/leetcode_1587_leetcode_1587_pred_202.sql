-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, '10000'), (10001, 'default1'), (0, NULL), (10000, 'default2'), (9999, 'unique_4'), (2, 'unique_5');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 0, 0, NULL), (10000, 10000, 10001, '2023-01-01'), (0, 9999, 10001, '2023-01-01'), (9999, NULL, 1, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_4', 10001)
('default2', 10001)
*/

-- Prediction Query
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY T.ACCOUNT HAVING BALANCE > '10000';

/*
Prediction Result:
*/