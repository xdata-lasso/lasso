-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (9999, NULL), (10000, 'default2'), (1, 'default1'), (10001, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (9999, 9999, 9999, '2023-01-02'), (10000, 10000, NULL, '2023-01-01'), (0, 1, 0, '2023-01-02'), (1, 10001, 9999, '2023-01-02'), (10001, 10001, 10001, '2023-01-01'), (2, 1, 10000, NULL), (3, 10001, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 20001)
*/

-- Prediction Query
SELECT NAME, BALANCE FROM USERS AS U LEFT JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS T ON U.ACCOUNT = T.ACCOUNT WHERE BALANCE >= 10000;

/*
Prediction Result:
('default1', 10000)
('unique_3', 20001)
*/