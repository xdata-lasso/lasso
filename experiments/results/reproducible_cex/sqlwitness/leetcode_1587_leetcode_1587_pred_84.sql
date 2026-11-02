-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, NULL), (0, 'default1'), (10000, 'default2');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (1, NULL, 10001, NULL), (0, 0, 10001, '2023-01-01'), (10000, NULL, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default1', 10001)
*/

-- Prediction Query
SELECT NAME, BALANCE FROM (SELECT ACCOUNT, NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS LEFT JOIN USERS USING (ACCOUNT) GROUP BY ACCOUNT, NAME HAVING SUM(AMOUNT) > 10000) AS A;

/*
Prediction Result:
(None, 20001)
('default1', 10001)
*/