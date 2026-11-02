-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (account, name) VALUES (1, NULL);
INSERT INTO Users (account, name) VALUES (2, NULL);
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 15000, '2020-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 2, 15000, '2020-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 15000)
(None, 15000)
*/

-- Prediction Query
WITH BALANCE AS (SELECT ACCOUNT, SUM(AMOUNT) OVER (PARTITION BY ACCOUNT ORDER BY TRANSACTED_ON) AS BALANCE, ROW_NUMBER() OVER (PARTITION BY ACCOUNT ORDER BY TRANSACTED_ON DESC) AS NUM FROM TRANSACTIONS) SELECT DISTINCT U.NAME, BALANCE FROM BALANCE AS B JOIN USERS AS U ON B.ACCOUNT = U.ACCOUNT WHERE NUM = 1 AND BALANCE > 10000;

/*
Prediction Result:
(None, 15000)
*/