-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (1, 'Alice');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (2, 'Bob');
INSERT INTO "CHECKING" ("custid", "balance") VALUES (1, 100.0);
INSERT INTO "CHECKING" ("custid", "balance") VALUES (2, 50.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (1, 200.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (2, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT balance AS balance___1, balance_other AS balance___2, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance, RHS.balance_other AS balance_other FROM accounts AS LHS INNER JOIN (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.balance AS balance_other FROM checking AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST, name NULLS LAST;

/*
Gold Result:
(50.0, 300.0, 'Bob')
(100.0, 200.0, 'Alice')
*/

-- Prediction Query
SELECT T2.balance, T3.balance, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid;

/*
Prediction Result:
(100.0, 200.0, 'Alice')
(50.0, 300.0, 'Bob')
*/