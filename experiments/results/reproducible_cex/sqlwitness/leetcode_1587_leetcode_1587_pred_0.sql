-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default1'), (10000, 'default2');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 1, NULL, '2023-01-01'), (10001, 10000, 9999, '2023-01-02'), (1, NULL, 0, NULL), (0, 1, 9999, NULL), (10000, 10000, 1, '2023-01-01'), (2, NULL, 10001, '2023-01-01'), (3, 10000, NULL, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS A JOIN TRANSACTIONS AS B ON A.ACCOUNT = B.ACCOUNT GROUP BY A.ACCOUNT HAVING SUM(AMOUNT) >= 10000;

/*
Prediction Result:
('default2', 10000)
*/