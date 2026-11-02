-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default2'), (1, NULL), (10000, 'default1'), (0, 'unique_3'), (10001, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 1, 10000, '2023-01-02'), (1, 8, 0, '2023-01-02'), (0, 7, NULL, '2023-01-01'), (10000, 6, NULL, '2023-01-01'), (10001, 8, 10000, '2023-01-02'), (2, 8, NULL, '2023-01-02'), (3, 10001, NULL, '2023-01-02'), (4, 9999, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME, SUM(TRANSACTIONS.AMOUNT) AS BALANCE FROM TRANSACTIONS JOIN USERS ON TRANSACTIONS.ACCOUNT = USERS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT HAVING BALANCE >= 10000;

/*
Prediction Result:
(None, 10000)
('unique_11', 10000)
('default2', 10000)
*/