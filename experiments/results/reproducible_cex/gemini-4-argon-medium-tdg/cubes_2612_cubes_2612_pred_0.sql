-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Zara');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, NULL);
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'David');
INSERT INTO CHECKING (custid, balance) VALUES (1, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (2, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (3, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (4, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (5, NULL);
INSERT INTO CHECKING (custid, balance) VALUES (6, -10.5);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (3, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, NULL);
INSERT INTO SAVINGS (custid, balance) VALUES (5, 20.0);
INSERT INTO SAVINGS (custid, balance) VALUES (6, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT balance AS balance___1, balance_other AS balance___2, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance, RHS.balance_other AS balance_other FROM accounts AS LHS INNER JOIN (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.balance AS balance_other FROM checking AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST, name NULLS LAST;

/*
Gold Result:
(None, 20.0, 'Charlie')
(-10.5, 0.0, 'David')
(50.0, 100.0, 'Alice')
(50.0, 100.0, 'Zara')
(50.0, 100.0, None)
(50.0, None, 'Bob')
*/

-- Prediction Query
SELECT T2.balance, T3.balance, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid;

/*
Prediction Result:
(50.0, 100.0, 'Zara')
(50.0, 100.0, 'Alice')
(50.0, 100.0, None)
(50.0, None, 'Bob')
(None, 20.0, 'Charlie')
(-10.5, 0.0, 'David')
*/