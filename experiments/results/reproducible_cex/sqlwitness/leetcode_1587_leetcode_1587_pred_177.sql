-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, NULL), (0, 'default2'), (10000, 'default1');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, NULL, 10000, '2023-01-01'), (10000, 0, 10000, '2023-01-02'), (1, 10000, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME, B.BALANCE FROM USERS AS A JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS B USING (ACCOUNT) WHERE B.BALANCE >= 10000;

/*
Prediction Result:
('default2', 10000)
*/