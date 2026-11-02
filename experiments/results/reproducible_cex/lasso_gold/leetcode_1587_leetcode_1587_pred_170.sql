-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (1097, NULL);
INSERT INTO "users" ("account", "name") VALUES (1098, NULL);
INSERT INTO "users" ("account", "name") VALUES (1099, NULL);
INSERT INTO "users" ("account", "name") VALUES (1103, NULL);
INSERT INTO "users" ("account", "name") VALUES (1104, NULL);
INSERT INTO "users" ("account", "name") VALUES (1105, NULL);
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1100, 1097, 10001, '1986-02-23');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1101, 1097, 10001, '1986-02-24');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1102, 1097, 10001, '1986-02-25');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1106, 1103, 10001, '1989-05-03');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1107, 1103, 10001, '1989-05-04');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1108, 1103, 10001, '1989-05-05');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
(None, 30003)
(None, 30003)
*/

-- Prediction Query
SELECT US.NAME AS NAME, SUM(TS.AMOUNT) AS BALANCE FROM USERS AS US JOIN TRANSACTIONS AS TS ON US.ACCOUNT = TS.ACCOUNT GROUP BY NAME HAVING BALANCE > 10000;

/*
Prediction Result:
(None, 60006)
*/