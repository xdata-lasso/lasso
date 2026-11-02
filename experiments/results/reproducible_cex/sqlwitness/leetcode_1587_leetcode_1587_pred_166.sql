-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default1'), (10001, NULL), (1, 'default2'), (10000, 'unique_3'), (0, 'unique_4');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 10001, 9999, '2023-01-02'), (9999, 1, 0, '2023-01-01'), (1, 1, 10001, NULL), (10000, 1, 10001, '2023-01-02'), (10001, 9999, 10000, '2023-01-01'), (2, 0, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 20002)
*/

-- Prediction Query
SELECT T1.NAME, T2.AMOUNT AS BALANCE FROM USERS AS T1 CROSS JOIN (SELECT SUM(AMOUNT) AS AMOUNT, ACCOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T2 WHERE T1.ACCOUNT = T2.ACCOUNT;

/*
Prediction Result:
('default2', 20002)
*/