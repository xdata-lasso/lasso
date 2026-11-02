-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Brown');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Brown');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Brown');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Brown');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Brown');
INSERT INTO CHECKING (custid, balance) VALUES (1, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (2, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (3, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (4, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (5, NULL);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 500.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 200.0);
INSERT INTO SAVINGS (custid, balance) VALUES (3, NULL);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 900.0);
INSERT INTO SAVINGS (custid, balance) VALUES (5, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "balance" AS "balance___1", "balance_other" AS "balance___2" FROM (SELECT "LHS"."custid" AS "custid", "LHS"."balance" AS "balance", "LHS"."name" AS "name", "RHS"."balance" AS "balance_other" FROM (SELECT * FROM (SELECT "LHS"."custid" AS "custid", "LHS"."balance" AS "balance", "RHS"."name" AS "name" FROM "checking" AS "LHS" LEFT JOIN "accounts" AS "RHS" ON ("LHS"."custid" = "RHS"."custid")) WHERE ("name" = 'Brown')) AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST;

/*
Gold Result:
(None, 100.0)
(50.0, 900.0)
(100.0, 200.0)
(100.0, 500.0)
(100.0, None)
*/

-- Prediction Query
SELECT T2.balance, T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid WHERE T1.name = 'Brown';

/*
Prediction Result:
(100.0, 500.0)
(100.0, 200.0)
(100.0, None)
(50.0, 900.0)
(None, 100.0)
*/