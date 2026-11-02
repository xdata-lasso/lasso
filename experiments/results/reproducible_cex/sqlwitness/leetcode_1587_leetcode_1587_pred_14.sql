-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, NULL), (9999, 'default2'), (0, 'default1'), (10001, 'unique_3'), (10000, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 10000, 9999, '2023-01-02'), (10000, 10001, 10000, '2023-01-02'), (1, 10000, 10001, '2023-01-01'), (0, 10000, 10000, '2023-01-02'), (9999, 6, 9999, '2023-01-02'), (2, 4, 1, '2023-01-01'), (3, 9, 10001, '2023-01-02'), (4, NULL, 10000, NULL), (5, 1, 9999, NULL), (6, 10000, 10000, '2023-01-01'), (7, 8, 1, '2023-01-01'), (8, NULL, 9999, '2023-01-01'), (9, 0, 10001, '2023-01-01'), (10, 6, NULL, '2023-01-01'), (11, 6, 9999, NULL), (12, 8, NULL, '2023-01-02'), (13, 11, 10001, '2023-01-02'), (14, 2, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default1', 10001)
('unique_5', 10001)
('unique_9', 19998)
('unique_12', 10001)
('unique_14', 10001)
('unique_4', 40000)
*/

-- Prediction Query
SELECT USERS.NAME AS NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS ON TRANSACTIONS.ACCOUNT = USERS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT HAVING SUM(AMOUNT) > 10000;

/*
Prediction Result:
(None, 19999)
('default1', 10001)
('unique_5', 10001)
('unique_9', 19998)
('unique_12', 10001)
('unique_14', 10001)
('unique_4', 40000)
*/