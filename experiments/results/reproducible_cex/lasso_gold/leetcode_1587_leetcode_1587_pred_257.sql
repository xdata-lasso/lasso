-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (2, 'Allison Hill');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1001, 2, 10001, '1970-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Allison Hill', 10001)
*/

-- Prediction Query
SELECT NAME AS NAME, SUM(AMOUNT) AS BALANCE FROM USERS INNER JOIN TRANSACTIONS ON TRUE WHERE USERS.ACCOUNT = TRANSACTIONS.ACCOUNT GROUP BY NAME HAVING SUM(AMOUNT) > '10000';

/*
Prediction Result:
*/