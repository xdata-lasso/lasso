-- Schema DDL
CREATE TABLE "Users" ("account" INTEGER PRIMARY KEY, "name" TEXT(255), UNIQUE ("name"));

CREATE TABLE "Transactions" ("trans_id" INTEGER PRIMARY KEY, "account" INTEGER, "amount" INTEGER, "transacted_on" DATE, FOREIGN KEY ("account") REFERENCES "Users" ("account"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("account", "name") VALUES (1021, 'Ryan Munoz');
INSERT INTO "users" ("account", "name") VALUES (1022, 'Monica Herrera');
INSERT INTO "users" ("account", "name") VALUES (1023, 'Jamie Arnold');
INSERT INTO "users" ("account", "name") VALUES (1040, NULL);
INSERT INTO "users" ("account", "name") VALUES (1041, NULL);
INSERT INTO "users" ("account", "name") VALUES (1042, NULL);
INSERT INTO "users" ("account", "name") VALUES (1046, NULL);
INSERT INTO "users" ("account", "name") VALUES (1047, 'Patty Perez');
INSERT INTO "users" ("account", "name") VALUES (1048, 'Ethan Adams');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1024, 1021, 10001, '1979-10-10');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1025, 1021, 10001, '1979-10-11');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1026, 1021, 10001, '1979-10-12');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1043, 1040, 10001, '1988-08-19');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1044, 1040, 10001, '1988-08-20');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1045, 1040, 10001, '1988-08-21');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1049, 1046, 10001, '1991-11-22');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1050, 1046, 10001, '1991-11-23');
INSERT INTO "transactions" ("trans_id", "account", "amount", "transacted_on") VALUES (1051, 1046, 10001, '1991-11-24');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT u.name, SUM(t.amount) AS balance FROM Users AS u CROSS JOIN Transactions AS t WHERE u.account = t.account GROUP BY t.account HAVING SUM(t.amount) > 10000;

/*
Gold Result:
('Ryan Munoz', 30003)
(None, 30003)
(None, 30003)
*/

-- Prediction Query
SELECT SUM(AMOUNT) AS BALANCE, U.NAME FROM TRANSACTIONS AS T JOIN USERS AS U ON T.ACCOUNT = U.ACCOUNT GROUP BY U.NAME HAVING BALANCE > 10000;

/*
Prediction Result:
(60006, None)
(30003, 'Ryan Munoz')
*/