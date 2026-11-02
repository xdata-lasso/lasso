-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO CHECKING (custid, balance) VALUES (1, 10.0);
INSERT INTO CHECKING (custid, balance) VALUES (2, 20.0);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 10.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT balance_other AS balance___1, balance AS balance___2, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, LHS.balance AS balance, RHS.custid AS custid_other, RHS.balance AS balance_other FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) AS LHS CROSS JOIN checking AS RHS) WHERE (custid = custid_other) ORDER BY balance___1, balance___2 NULLS LAST, name NULLS LAST;

/*
Gold Result:
(10.0, 10.0, 'Alice')
(20.0, 20.0, 'Bob')
*/

-- Prediction Query
SELECT T2.balance, T3.balance, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid ORDER BY T2.balance + T3.balance DESC, T1.custid NULLS LAST, T2.custid NULLS LAST, T3.custid NULLS LAST;

/*
Prediction Result:
(20.0, 20.0, 'Bob')
(10.0, 10.0, 'Alice')
*/