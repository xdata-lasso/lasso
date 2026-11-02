-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default2'), (9999, NULL), (10001, 'default1'), (10000, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 9999, 10001, '2023-01-02'), (1, 2, 10000, NULL), (10000, 4, 9999, NULL), (9999, 10000, 0, '2023-01-01'), (10001, 10000, 0, '2023-01-02'), (2, 3, NULL, NULL), (3, NULL, 10001, NULL), (4, 0, 9999, '2023-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 10001)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U LEFT JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY NAME HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
(None, 10001)
('unique_5', 10000)
*/