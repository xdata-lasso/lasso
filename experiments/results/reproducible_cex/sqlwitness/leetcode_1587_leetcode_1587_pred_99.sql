-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10000, 'default1'), (9999, 'default2'), (0, NULL), (1, 'unique_3'), (10001, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, NULL, 1, '2023-01-02'), (0, 3, 0, '2023-01-02'), (10001, 10001, 10000, NULL), (10000, 1, 10001, '2023-01-02'), (9999, 1, NULL, '2023-01-01'), (2, 10001, 1, '2023-01-01'), (3, 10001, 9999, NULL), (4, 9999, 1, '2023-01-01'), (5, 4, 1, NULL), (6, 2, 1, NULL), (7, 4, 10001, '2023-01-02'), (8, NULL, NULL, NULL), (9, 10000, 9999, NULL), (10, 10000, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 10001)
('unique_7', 10002)
('default1', 19999)
('unique_4', 20000)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U LEFT JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY U.ACCOUNT HAVING SUM(AMOUNT) > 10000 ORDER BY NAME, BALANCE NULLS LAST;

/*
Prediction Result:
('default1', 19999)
('unique_3', 10001)
('unique_4', 20000)
('unique_7', 10002)
*/