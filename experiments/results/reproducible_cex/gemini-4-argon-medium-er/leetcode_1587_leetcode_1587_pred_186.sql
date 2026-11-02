-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Users (account, name) VALUES (1, NULL);
INSERT INTO Users (account, name) VALUES (2, NULL);
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (1, 1, 20000, '2023-01-01');
INSERT INTO Transactions (trans_id, account, amount, transacted_on) VALUES (2, 2, 20000, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 20000)
(None, 20000)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U CROSS JOIN TRANSACTIONS AS T WHERE U.ACCOUNT = T.ACCOUNT GROUP BY U.NAME HAVING BALANCE > 10000 ORDER BY BALANCE DESC, NAME NULLS LAST;

/*
Prediction Result:
(None, 40000)
*/