-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Users" ("account", "name") VALUES (24, NULL);
INSERT INTO "Users" ("account", "name") VALUES (14, '15');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (17, 24, -554, '1000-01-23');
INSERT INTO "Transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (16, 24, -410, '1000-01-26');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT NAME, SUM(AMOUNT) AS BALANCE FROM USERS AS U LEFT JOIN TRANSACTIONS AS T ON U.ACCOUNT = T.ACCOUNT GROUP BY NAME) AS A WHERE A.BALANCE > 10000;

/*
Prediction Result:
*/