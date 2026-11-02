-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (2, 'default2'), (10000, 'default1'), (10001, NULL), (9999, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (2, 10000, 9999, NULL), (9999, 9999, 0, NULL), (10000, NULL, 10001, '2023-01-01'), (10001, 2, 2, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT (SELECT NAME FROM USERS WHERE ACCOUNT = A.ACCOUNT) AS NAME, SUM(A.AMOUNT) AS BALANCE FROM TRANSACTIONS AS A GROUP BY 1 HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
*/