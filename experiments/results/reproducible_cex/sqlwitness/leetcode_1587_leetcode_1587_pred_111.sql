-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, NULL), (10001, 'default1'), (2, 'default2'), (10000, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, 10001, 10000, '2023-01-02'), (10001, NULL, 9999, '2023-01-01'), (2, NULL, 2, NULL), (9999, 2, 10000, NULL), (0, 10001, 10000, '2023-01-02'), (1, 10000, 2, NULL), (3, 2, 9999, '2023-01-02'), (4, 10001, 10001, NULL), (5, 2, 0, NULL), (6, 10001, NULL, NULL), (7, 10000, 9999, '2023-01-02'), (8, 10001, 10001, NULL), (9, 2, 1, NULL), (10, 10000, 0, '2023-01-02'), (11, 2, 10001, '2023-01-01'), (12, 10001, 9999, NULL), (13, 10001, 0, '2023-01-01'), (14, 10000, 1, '2023-01-01'), (15, 2, 10001, '2023-01-01'), (16, NULL, 10000, NULL), (17, 10001, 1, '2023-01-01'), (18, NULL, 9999, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 40002)
('unique_3', 10002)
('default1', 50002)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY 1 HAVING SUM(T.AMOUNT) > 10000 ORDER BY 1, NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
('default1', 50002)
('default2', 40002)
('unique_3', 10002)
*/