-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, 'default1'), (10000, NULL), (9999, 'default2'), (1, 'unique_3'), (0, 'unique_4'), (2, 'unique_5');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 9999, 10000, NULL), (3, 10001, 3, '2023-01-02'), (2, 9999, 10000, '2023-01-01'), (10000, 1, 3, '2023-01-01'), (0, 10001, NULL, '2023-01-01'), (1, 0, 10001, '2023-01-01'), (9999, NULL, 0, '2023-01-02'), (4, 9999, 1, '2023-01-02'), (5, 1, 1, '2023-01-01'), (6, 9999, NULL, '2023-01-02'), (7, 10000, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_4', 10001)
('default2', 20001)
*/

-- Prediction Query
SELECT U.NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY 1 HAVING SUM(AMOUNT) > 10000 ORDER BY 1, 2, U.NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
('default2', 20001)
('unique_4', 10001)
*/