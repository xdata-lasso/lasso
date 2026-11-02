-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default1'), (9999, NULL), (10001, 'default2'), (10000, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 9999, 10000, '2023-01-01'), (1, 0, 10001, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default1', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS NATURAL JOIN TRANSACTIONS GROUP BY ACCOUNT HAVING BALANCE >= 10000;

/*
Prediction Result:
('default1', 10001)
(None, 10000)
*/