-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default2'), (1, 'default1'), (10000, NULL);
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10001, 10000, 9999, '2023-01-02'), (1, 9999, 1, NULL), (0, 10000, 10001, '2023-01-01'), (10000, NULL, 9999, NULL), (9999, 10000, 0, '2023-01-02'), (2, 9999, 10000, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 10001)
(None, 20000)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM TRANSACTIONS AS T JOIN USERS AS U USING (ACCOUNT) GROUP BY U.NAME HAVING SUM(T.AMOUNT) > 10000 ORDER BY SUM(T.AMOUNT) DESC, NAME NULLS LAST, BALANCE NULLS LAST;

/*
Prediction Result:
(None, 20000)
('default2', 10001)
*/