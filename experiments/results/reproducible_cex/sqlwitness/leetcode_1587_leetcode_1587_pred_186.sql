-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO users (account, name) VALUES (1, 'default1'), (10001, NULL), (9999, 'default2'), (10000, 'unique_3');
INSERT INTO transactions (trans_id, account, amount, transacted_on) VALUES (10000, 10000, 10001, '2023-01-02'), (1, 9999, 10001, '2023-01-01'), (10001, 10000, 9999, '2023-01-02'), (9999, 9999, 10000, NULL), (0, 10000, 9999, '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('default2', 20001)
('unique_3', 29999)
*/

-- Prediction Query
SELECT U.NAME AS NAME, SUM(T.AMOUNT) AS BALANCE FROM USERS AS U CROSS JOIN TRANSACTIONS AS T WHERE U.ACCOUNT = T.ACCOUNT GROUP BY U.NAME HAVING BALANCE > 10000 ORDER BY BALANCE DESC, NAME NULLS LAST;

/*
Prediction Result:
('unique_3', 29999)
('default2', 20001)
*/