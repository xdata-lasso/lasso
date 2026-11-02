-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (account, name) VALUES (1, 'Alice');
INSERT INTO Users (account, name) VALUES (2, 'Bob');
INSERT INTO Users (account, name) VALUES (3, 'Charlie');
INSERT INTO Users (account, name) VALUES (4, 'Diana');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (101, 1, 6000, '2023-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (102, 1, 4000, '2023-01-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (103, 2, 7000, '2023-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (104, 2, 3001, '2023-01-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (105, 3, 9999, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Bob', 10001)
*/

-- Prediction Query
WITH T1 AS (SELECT T.TRANS_ID, T.ACCOUNT, T.AMOUNT, T.TRANSACTED_ON, U.NAME FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT), T2 AS (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM T1 GROUP BY ACCOUNT) SELECT NAME, BALANCE FROM T2 WHERE BALANCE >= 10000;

/*
Prediction Result:
('Alice', 10000)
('Bob', 10001)
*/