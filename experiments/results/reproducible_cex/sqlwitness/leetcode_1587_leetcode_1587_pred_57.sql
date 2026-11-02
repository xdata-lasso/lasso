-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, NULL, 10000, '2023-01-01'), (0, NULL, 1, '2023-01-02'), (1, NULL, 10000, NULL), (10000, NULL, 9999, '2023-01-02'), (10001, NULL, 0, '2023-01-01'), (2, NULL, 9999, NULL), (3, NULL, 10001, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME AS NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS USING (ACCOUNT) GROUP BY ACCOUNT HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 50000)
*/