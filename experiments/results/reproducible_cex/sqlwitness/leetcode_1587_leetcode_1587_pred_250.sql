-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (0, 'default1'), (10000, 'default2'), (9999, NULL), (10001, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 0, 1, NULL), (10000, NULL, 0, '2023-01-01'), (10001, 10000, 10000, '2023-01-02'), (0, 10000, NULL, '2023-01-02'), (1, NULL, 10000, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS INNER JOIN TRANSACTIONS AS T ON USERS.ACCOUNT = T.ACCOUNT GROUP BY T.ACCOUNT HAVING SUM(T.AMOUNT) >= 10000;

/*
Prediction Result:
('default2', 10000)
*/