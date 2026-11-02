-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (account, name) VALUES (1, 'Alice');
INSERT INTO Users (account, name) VALUES (2, 'Bob');
INSERT INTO Users (account, name) VALUES (3, 'Charlie');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (101, 1, 6000, '2020-08-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (102, 1, 6000, '2020-08-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (103, 2, 10000, '2020-08-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (104, 3, 15000, '2020-08-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (105, 3, -6000, '2020-08-02');
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
('Charlie', 9000)
*/