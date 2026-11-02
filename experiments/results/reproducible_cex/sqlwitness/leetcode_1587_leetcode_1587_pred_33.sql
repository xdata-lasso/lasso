-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default1'), (10000, 'default2'), (0, NULL), (9999, 'unique_3'), (10001, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 5, 0, '2023-01-01'), (10001, 6, 9999, '2023-01-02'), (1, 10000, NULL, '2023-01-02'), (10000, 10001, 1, NULL), (9999, 3, NULL, NULL), (2, 4, NULL, NULL), (3, 6, 1, '2023-01-01'), (4, 4, 10000, '2023-01-02'), (5, 7, 10001, '2023-01-02'), (6, 2, 0, '2023-01-01'), (7, 6, 10001, NULL), (8, 0, 10000, '2023-01-01'), (9, 10001, 10001, '2023-01-01'), (10, 0, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
('unique_9', 20001)
('unique_10', 10001)
('unique_4', 10002)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT HAVING SUM(AMOUNT) > 10000 ORDER BY NAME, BALANCE NULLS LAST;

/*
Prediction Result:
(None, 10001)
('unique_10', 10001)
('unique_4', 10002)
('unique_9', 20001)
*/