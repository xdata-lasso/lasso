-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, NULL, 10000, NULL), (10000, NULL, 0, NULL), (9999, NULL, 9999, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U1.NAME, SUM(T1.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T1 LEFT OUTER JOIN USERS AS U1 ON U1.ACCOUNT = T1.ACCOUNT GROUP BY T1.ACCOUNT HAVING SUM(T1.AMOUNT) > 10000;

/*
Prediction Result:
(None, 19999)
*/