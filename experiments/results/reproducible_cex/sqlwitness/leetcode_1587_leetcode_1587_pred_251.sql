-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default2'), (10001, NULL), (0, 'default1'), (10000, 'unique_3'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, 10001, 10000, NULL), (9999, 9, 0, '2023-01-01'), (0, 3, 10000, '2023-01-01'), (10001, 3, 0, NULL), (1, 7, 10000, NULL), (2, 8, 10000, '2023-01-02'), (3, 2, 0, '2023-01-02'), (4, 0, NULL, '2023-01-01'), (5, 9, 10001, '2023-01-02'), (6, 8, 9999, '2023-01-02'), (7, 1, 10000, NULL), (8, 3, 9999, '2023-01-02'), (9, 9, 10000, NULL), (10, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_6', 19999)
('unique_11', 19999)
('unique_12', 20001)
*/

-- Prediction Query
SELECT USERS.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS CROSS JOIN USERS WHERE USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT HAVING SUM(AMOUNT) > 10000 ORDER BY SUM(AMOUNT) DESC, USERS.NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
('unique_12', 20001)
('unique_11', 19999)
('unique_6', 19999)
*/