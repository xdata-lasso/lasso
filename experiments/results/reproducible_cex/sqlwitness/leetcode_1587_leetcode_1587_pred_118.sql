-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, NULL), (1, 'default2'), (10001, 'default1'), (10000, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, NULL, 9999, NULL), (9999, 10001, 10000, '2023-01-02'), (10000, 6, NULL, '2023-01-01'), (10001, 7, 9999, '2023-01-02'), (1, 10001, 9999, '2023-01-01'), (2, 2, 0, '2023-01-01'), (3, 3, 0, '2023-01-01'), (4, 7, 1, '2023-01-01'), (5, 9999, 10001, '2023-01-02'), (6, NULL, 0, '2023-01-02'), (7, 1, 9999, NULL), (8, 0, 0, '2023-01-01'), (9, NULL, 0, NULL), (10, 10000, 10001, '2023-01-02'), (11, 2, 10001, NULL), (12, 9, 0, NULL), (13, 6, 0, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_5', 10001)
(None, 10001)
('unique_3', 10001)
('default1', 19999)
*/

-- Prediction Query
SELECT U.NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY U.NAME HAVING BALANCE > 10000 ORDER BY U.NAME, BALANCE NULLS LAST;

/*
Prediction Result:
(None, 10001)
('default1', 19999)
('unique_3', 10001)
('unique_5', 10001)
*/