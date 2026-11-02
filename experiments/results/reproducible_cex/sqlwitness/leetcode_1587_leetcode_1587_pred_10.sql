-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, NULL), (1, 'default2'), (0, 'default1'), (10000, 'unique_3'), (9999, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 9999, 1, '2023-01-01'), (9999, 4, 10001, '2023-01-02'), (10000, 4, 9999, '2023-01-02'), (1, 5, 1, '2023-01-02'), (10001, 1, 9999, '2023-01-02'), (2, 3, 10000, NULL), (3, 5, 0, NULL), (4, 1, 0, '2023-01-01'), (5, 1, NULL, NULL), (6, 6, 10001, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_7', 20000)
('unique_9', 10001)
*/

-- Prediction Query
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON T.ACCOUNT = U.ACCOUNT GROUP BY U.NAME HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
('unique_6', 10000)
('unique_7', 20000)
('unique_9', 10001)
*/