-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (10001, NULL), (1, 'default2'), (10000, 'default1'), (9999, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (0, 10000, 10000, '2023-01-01'), (1, 9999, 10001, '2023-01-02'), (10001, NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('unique_3', 10001)
*/

-- Prediction Query
SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS S LEFT JOIN TRANSACTIONS AS T ON S.ACCOUNT = T.ACCOUNT GROUP BY NAME HAVING BALANCE >= 10000;

/*
Prediction Result:
('default1', 10000)
('unique_3', 10001)
*/