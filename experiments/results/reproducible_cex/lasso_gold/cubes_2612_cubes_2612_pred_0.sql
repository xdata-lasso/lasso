-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1027, 'Gabrielle Davis');
INSERT INTO "accounts" ("custid", "name") VALUES (1030, 'Monica Herrera');
INSERT INTO "checking" ("custid", "balance") VALUES (1027, 1029.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1030, 1028.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1027, 1029.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1030, 1030.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT balance AS balance___1, balance_other AS balance___2, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance, RHS.balance_other AS balance_other FROM accounts AS LHS INNER JOIN (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.balance AS balance_other FROM checking AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST, name NULLS LAST;

/*
Gold Result:
(1028.5, 1030.5, 'Monica Herrera')
(1029.5, 1029.5, 'Gabrielle Davis')
*/

-- Prediction Query
SELECT T2.balance, T3.balance, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid;

/*
Prediction Result:
(1029.5, 1029.5, 'Gabrielle Davis')
(1028.5, 1030.5, 'Monica Herrera')
*/