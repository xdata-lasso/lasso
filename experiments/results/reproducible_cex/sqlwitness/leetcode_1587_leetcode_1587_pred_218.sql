-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default1'), (0, NULL), (10001, 'default2'), (10000, 'unique_3'), (1, 'unique_4'), (2, 'unique_5');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, NULL, 10000, NULL), (0, 10000, 0, '2023-01-02'), (10000, 10000, 10001, NULL), (9999, 9999, 10000, NULL), (10001, 0, 9999, '2023-01-01'), (2, 0, 10000, NULL), (3, 9999, NULL, NULL), (4, 10000, 10001, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 19999)
('unique_3', 20002)
*/

-- Prediction Query
SELECT USERS.NAME, SUM(TRANSACTIONS.AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY TRANSACTIONS.ACCOUNT HAVING SUM(TRANSACTIONS.AMOUNT) >= 10000;

/*
Prediction Result:
(None, 10000)
(None, 19999)
('default1', 10000)
('unique_3', 20002)
*/