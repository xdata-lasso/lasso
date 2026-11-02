-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, NULL), (10001, 'default2'), (9999, 'default1'), (10000, 'unique_3'), (0, 'unique_4');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, 9999, NULL, NULL), (10000, 10000, 10000, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U INNER JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT, U.NAME HAVING BALANCE >= 10000;

/*
Prediction Result:
('unique_3', 10000)
*/