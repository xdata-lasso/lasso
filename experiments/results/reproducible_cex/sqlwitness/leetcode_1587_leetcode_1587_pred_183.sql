-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10000, NULL), (1, 'default1');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, NULL, 10000, '2023-01-01'), (0, NULL, 9999, '2023-01-01'), (9999, NULL, 10001, '2023-01-01'), (10001, 10000, 10000, '2023-01-01'), (1, 10000, 10000, '2023-01-01'), (2, 1, 9999, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 20000)
*/

-- Prediction Query
SELECT * FROM (SELECT USERS.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT) AS T1 WHERE BALANCE > 10000;

/*
Prediction Result:
(None, 30000)
(None, 20000)
*/