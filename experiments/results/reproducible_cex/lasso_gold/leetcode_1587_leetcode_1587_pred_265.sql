-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (2, 'Michele Williams');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1025, 2, 6667, '1984-04-15');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1026, 2, 3333, '1984-04-15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT USERS.NAME AS NAME, BALANCES.BALANCE AS BALANCE FROM (SELECT ACCOUNT, SUM(AMOUNT) AS BALANCE FROM TRANSACTIONS GROUP BY ACCOUNT) AS BALANCES INNER JOIN USERS ON BALANCES.ACCOUNT = USERS.ACCOUNT WHERE BALANCE >= 10000;

/*
Prediction Result:
('Michele Williams', 10000)
*/