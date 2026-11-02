-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, NULL, 10001, '2023-01-02'), (9999, NULL, 1, '2023-01-02'), (1, NULL, 1, '2023-01-01'), (10000, NULL, 9999, '2023-01-02'), (10001, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T LEFT JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT GROUP BY T.ACCOUNT HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 20002)
*/