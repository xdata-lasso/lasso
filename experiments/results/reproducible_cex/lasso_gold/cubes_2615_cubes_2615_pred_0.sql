-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1080, 'Sherri Baker');
INSERT INTO "accounts" ("custid", "name") VALUES (1081, 'Cassandra Gaines');
INSERT INTO "accounts" ("custid", "name") VALUES (1082, 'Elizabeth Fowler');
INSERT INTO "accounts" ("custid", "name") VALUES (1092, 'Sherry Decker');
INSERT INTO "accounts" ("custid", "name") VALUES (1093, 'Anthony Humphrey');
INSERT INTO "accounts" ("custid", "name") VALUES (1094, 'Angelica Tucker');
INSERT INTO "accounts" ("custid", "name") VALUES (1086, NULL);
INSERT INTO "checking" ("custid", "balance") VALUES (1080, 1083.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1081, 1088.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1082, 1093.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1086, 1083.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1092, 1095.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1093, 1100.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1094, 1105.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT custid, name FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, LHS.name AS name, LHS.maxbalance AS maxbalance, RHS.custid AS custid_other, RHS.balance AS balance_other FROM (SELECT custid, balance, name, MAX(balance) OVER () AS maxbalance FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM checking AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid))) AS LHS CROSS JOIN checking AS RHS) WHERE (balance = balance_other AND maxbalance <> balance_other) ORDER BY custid, name NULLS LAST;

/*
Gold Result:
(1080, 'Sherri Baker')
(1080, 'Sherri Baker')
(1081, 'Cassandra Gaines')
(1082, 'Elizabeth Fowler')
(1086, None)
(1086, None)
(1092, 'Sherry Decker')
(1093, 'Anthony Humphrey')
*/

-- Prediction Query
SELECT T1.custid, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT MAX(balance) FROM checking);

/*
Prediction Result:
(1080, 'Sherri Baker')
(1081, 'Cassandra Gaines')
(1082, 'Elizabeth Fowler')
(1086, None)
(1092, 'Sherry Decker')
(1093, 'Anthony Humphrey')
*/