-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, 'default1'), (10000, 'default2'), (1, NULL);
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, NULL, 0, '2023-01-01'), (0, NULL, 10000, NULL), (1, 10000, 0, NULL), (9999, 10000, 10000, '2023-01-01'), (10001, 1, 0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS INNER JOIN USERS ON USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY NAME HAVING BALANCE >= 10000;

/*
Prediction Result:
('default2', 10000)
*/