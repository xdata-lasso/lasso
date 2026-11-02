-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Users (account, name) VALUES (1, 'Alice');
INSERT INTO Users (account, name) VALUES (2, 'Bob');
INSERT INTO Users (account, name) VALUES (3, 'Charlie');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (101, 1, 6000, '2023-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (102, 1, 5000, '2023-01-02');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (103, 2, 10000, '2023-01-03');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (104, 3, 15000, '2023-01-04');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (105, 3, -6000, '2023-01-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Alice', 11000)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY T.ACCOUNT HAVING BALANCE >= 10000;

/*
Prediction Result:
('Alice', 11000)
('Bob', 10000)
*/