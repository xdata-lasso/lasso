-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, NULL), (10000, 'default1'), (9999, 'default2'), (10001, 'unique_3'), (1, 'unique_4'), (3, 'unique_5'), (2, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (3, 9999, 9999, '2023-01-02'), (9999, 10001, 10001, '2023-01-02'), (1, 2, 10000, '2023-01-01'), (0, 10000, NULL, '2023-01-02'), (10000, 6, 9999, NULL), (2, 0, 0, '2023-01-02'), (10001, 9999, 2, NULL), (4, 0, 0, NULL), (5, 7, 10001, '2023-01-02'), (6, 5, 10000, NULL), (7, 9999, 0, '2023-01-02'), (8, 5, 9999, NULL), (9, 2, 2, '2023-01-02'), (10, NULL, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_6', 10002)
('unique_8', 19999)
('unique_10', 10001)
('default2', 10001)
('unique_3', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS INNER JOIN TRANSACTIONS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY USERS.ACCOUNT HAVING BALANCE > 10000 ORDER BY 2 DESC, NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
('unique_8', 19999)
('unique_6', 10002)
('default2', 10001)
('unique_10', 10001)
('unique_3', 10001)
*/