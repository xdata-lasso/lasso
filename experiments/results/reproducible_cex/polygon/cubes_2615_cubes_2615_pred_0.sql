-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (23, '29');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (24, '30');
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (23, -554);
INSERT INTO "CHECKING" ("custid", "balance") VALUES (24, -554);
INSERT INTO "CHECKING" ("custid", "balance") VALUES (23, -1561);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT custid, name FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, LHS.name AS name, LHS.maxbalance AS maxbalance, RHS.custid AS custid_other, RHS.balance AS balance_other FROM (SELECT custid, balance, name, MAX(balance) OVER () AS maxbalance FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM checking AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid))) AS LHS CROSS JOIN checking AS RHS) WHERE (balance = balance_other AND maxbalance <> balance_other) ORDER BY custid, name NULLS LAST;

/*
Gold Result:
(23, '29')
*/

-- Prediction Query
SELECT T1.custid, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT MAX(balance) FROM checking);

/*
Prediction Result:
(23, '29')
*/