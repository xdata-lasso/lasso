-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (account, name) VALUES (1, 'Alice');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 6000, '2020-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 1, 6000, '2020-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Alice', 12000)
*/

-- Prediction Query
SELECT T1.NAME, T2.AMOUNT AS BALANCE FROM USERS AS T1 CROSS JOIN (SELECT SUM(AMOUNT) AS AMOUNT, ACCOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T2 WHERE T1.ACCOUNT = T2.ACCOUNT;

/*
Prediction Result:
*/