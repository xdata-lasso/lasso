-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ACCOUNTS (custid, name) VALUES (10, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (20, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (30, 'David');
INSERT INTO ACCOUNTS (custid, name) VALUES (40, 'Eve');
INSERT INTO CHECKING (custid, balance) VALUES (10, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (20, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (30, 200.0);
INSERT INTO CHECKING (custid, balance) VALUES (40, 400.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT custid, name FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, LHS.name AS name, LHS.maxbalance AS maxbalance, RHS.custid AS custid_other, RHS.balance AS balance_other FROM (SELECT custid, balance, name, MAX(balance) OVER () AS maxbalance FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM checking AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid))) AS LHS CROSS JOIN checking AS RHS) WHERE (balance = balance_other AND maxbalance <> balance_other) ORDER BY custid, name NULLS LAST;

/*
Gold Result:
(10, 'Charlie')
(10, 'Charlie')
(20, 'Bob')
(20, 'Bob')
(30, 'David')
*/

-- Prediction Query
SELECT T1.custid, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT MAX(balance) FROM checking);

/*
Prediction Result:
(10, 'Charlie')
(20, 'Bob')
(30, 'David')
*/