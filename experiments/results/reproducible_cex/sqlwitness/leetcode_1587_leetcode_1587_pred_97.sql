-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default1'), (10001, NULL), (10000, 'default2'), (9999, 'unique_3'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13'), (11, 'unique_14'), (12, 'unique_15'), (13, 'unique_16'), (14, 'unique_17'), (15, 'unique_18');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 12, NULL, NULL), (9999, 4, 0, '2023-01-01'), (0, 6, 10001, '2023-01-01'), (10000, 14, 10000, '2023-01-01'), (1, 3, NULL, '2023-01-02'), (2, NULL, 10001, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_9', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS AS T LEFT JOIN USERS AS U USING (ACCOUNT) GROUP BY ACCOUNT HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 10001)
('unique_9', 10001)
*/