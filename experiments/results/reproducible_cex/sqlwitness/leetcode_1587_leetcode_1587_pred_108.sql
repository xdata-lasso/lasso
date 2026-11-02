-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default1'), (10000, 'default2'), (9999, NULL);
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 9999, 0, NULL), (9999, NULL, 10000, '2023-01-01'), (1, NULL, 1, '2023-01-01'), (0, 9999, 10000, NULL), (10000, 0, 1, NULL), (2, NULL, 1, NULL), (3, 0, NULL, NULL), (4, 0, 10000, NULL), (5, 9999, 10001, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default1', 10001)
(None, 20001)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT GROUP BY U.NAME HAVING SUM(T.AMOUNT) > 10000;

/*
Prediction Result:
(None, 30003)
('default1', 10001)
*/