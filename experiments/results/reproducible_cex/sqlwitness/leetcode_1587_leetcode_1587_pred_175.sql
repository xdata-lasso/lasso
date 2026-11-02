-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default1'), (10001, NULL), (10000, 'default2'), (1, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, 6, 9999, NULL), (9999, 5, 10001, '2023-01-01'), (10001, 10001, 10001, NULL), (1, 10001, 9999, NULL), (0, 7, 1, NULL), (2, 12, 10001, '2023-01-01'), (3, 9, 9999, '2023-01-01'), (4, 0, NULL, '2023-01-01'), (5, 10000, 10000, '2023-01-01'), (6, 12, NULL, NULL), (7, 0, NULL, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_8', 10001)
('unique_15', 10001)
(None, 20000)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U CROSS JOIN TRANSACTIONS AS T WHERE U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT, T.ACCOUNT HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
('unique_8', 10001)
('unique_15', 10001)
('default2', 10000)
(None, 20000)
*/