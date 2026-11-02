-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, 'default1'), (0, NULL), (9999, 'default2'), (10000, 'unique_3'), (1, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, NULL, 10001, '2023-01-02'), (10000, 6, 9999, '2023-01-01'), (10001, 3, 10001, '2023-01-02'), (9999, 1, NULL, NULL), (1, 6, 10001, '2023-01-01'), (2, 7, 9999, '2023-01-01'), (3, 7, 0, NULL), (4, 3, 10001, '2023-01-01'), (5, 1, 10000, '2023-01-01'), (6, 4, 0, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_6', 20002)
('unique_9', 20000)
*/

-- Prediction Query
SELECT USERS.NAME, TMP2.BALANCE FROM (SELECT ACCOUNT, BALANCE FROM (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS TMP WHERE BALANCE >= 10000) AS TMP2 INNER JOIN USERS ON USERS.ACCOUNT = TMP2.ACCOUNT;

/*
Prediction Result:
('unique_4', 10000)
('unique_6', 20002)
('unique_9', 20000)
*/