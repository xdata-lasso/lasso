-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, NULL), (0, 'default2'), (9999, 'default1'), (10000, 'unique_3'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 10000, 0, '2023-01-01'), (10001, 10001, 9999, '2023-01-02'), (1, 1, 10000, NULL), (10000, 4, 0, '2023-01-01'), (9999, 4, 1, '2023-01-02'), (2, 6, 1, NULL), (3, 5, 1, '2023-01-01'), (4, 6, 1, '2023-01-02'), (5, 4, 9999, '2023-01-01'), (6, 10001, 1, '2023-01-01'), (7, 9999, 9999, '2023-01-01'), (8, 10001, 0, '2023-01-01'), (9, 9999, 10001, NULL), (10, 6, 10000, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_9', 10002)
('default1', 20000)
*/

-- Prediction Query
SELECT T1.NAME AS NAME, T2.BALANCE AS BALANCE FROM USERS AS T1 LEFT JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS T2 ON T1.ACCOUNT = T2.ACCOUNT WHERE T2.BALANCE >= 10000;

/*
Prediction Result:
('unique_4', 10000)
('unique_7', 10000)
('unique_9', 10002)
('default1', 20000)
(None, 10000)
*/