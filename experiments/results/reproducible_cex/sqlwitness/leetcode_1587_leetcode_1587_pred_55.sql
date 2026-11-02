-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, 'default2'), (9999, NULL), (10000, 'default1'), (1, 'unique_3'), (0, 'unique_4'), (2, 'unique_5'), (3, 'unique_6'), (4, 'unique_7'), (5, 'unique_8'), (6, 'unique_9'), (7, 'unique_10'), (8, 'unique_11'), (9, 'unique_12'), (10, 'unique_13');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 10001, 10000, '2023-01-02'), (9999, 8, 9999, '2023-01-01'), (1, 10000, 9999, '2023-01-02'), (0, 5, 10000, NULL), (10000, 10000, 0, NULL), (2, 0, 1, '2023-01-01'), (3, 9999, 1, NULL), (4, 5, NULL, '2023-01-02'), (5, 10001, 1, NULL), (6, 0, 10001, '2023-01-01'), (7, 7, 1, '2023-01-02'), (8, 10, 9999, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_4', 10002)
('default2', 10001)
*/

-- Prediction Query
SELECT A.NAME, SUM(B.AMOUNT) AS BALANCE FROM USERS AS A JOIN TRANSACTIONS AS B ON A.ACCOUNT = B.ACCOUNT GROUP BY A.NAME HAVING SUM(B.AMOUNT) > 10000 ORDER BY A.NAME, BALANCE NULLS LAST;

/*
Prediction Result:
('default2', 10001)
('unique_4', 10002)
*/