-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (2, 'Angie Henderson');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1004, 2, 6000, '1972-03-03');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1005, 2, 6000, '1972-03-03');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Angie Henderson', 12000)
*/

-- Prediction Query
SELECT NAME, AMOUNT AS BALANCE FROM USERS AS U JOIN (SELECT ACCOUNT, SUM(AMOUNT) AS AMOUNT FROM TRANSACTIONS GROUP BY ACCOUNT HAVING AMOUNT > 10000) AS T ON U.ACCOUNT = T.ACCOUNT;

/*
Prediction Result:
*/