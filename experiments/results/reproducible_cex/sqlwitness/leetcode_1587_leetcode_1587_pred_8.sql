-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, 'default1'), (9999, NULL), (1, 'default2'), (10000, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 0, 10001, '2023-01-01'), (9999, 5, 10000, '2023-01-02'), (1, 10000, 10000, '2023-01-01'), (0, 2, 1, '2023-01-02'), (10000, NULL, 0, '2023-01-02'), (2, 2, 9999, NULL), (3, 2, 10000, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_4', 10001)
('unique_5', 20000)
*/

-- Prediction Query
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T INNER JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT GROUP BY U.NAME HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
('unique_3', 10000)
('unique_4', 10001)
('unique_5', 20000)
('unique_8', 10000)
*/