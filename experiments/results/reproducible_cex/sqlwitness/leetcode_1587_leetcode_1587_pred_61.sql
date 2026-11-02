-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10000, NULL), (9999, 'default1'), (1, 'default2'), (10001, 'unique_3'), (0, 'unique_4'), (2, 'unique_5');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 10001, 10001, '2023-01-02'), (10000, NULL, 10001, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 10001)
*/

-- Prediction Query
WITH CTE AS (SELECT TRANSACTIONS.*, USERS.NAME FROM TRANSACTIONS LEFT JOIN USERS ON TRANSACTIONS.ACCOUNT = USERS.ACCOUNT) SELECT NAME, SUM(AMOUNT) AS BALANCE FROM CTE GROUP BY NAME HAVING (BALANCE > 10000);

/*
Prediction Result:
(None, 10001)
('unique_3', 10001)
*/