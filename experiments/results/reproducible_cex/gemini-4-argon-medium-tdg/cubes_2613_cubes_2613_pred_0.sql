-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Charlie');
INSERT INTO SAVINGS (custid, balance) VALUES (1, 1500.50);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 200.00);
INSERT INTO CHECKING (custid, balance) VALUES (1, 9999.99);
INSERT INTO CHECKING (custid, balance) VALUES (3, 500.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumbalance AS sum_t2_balance_, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.sumbalance AS sumbalance FROM accounts AS LHS INNER JOIN (SELECT custid, SUM(balance) AS sumbalance FROM savings GROUP BY custid) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY sum_t2_balance_, name NULLS LAST;

/*
Gold Result:
(200.0, 'Bob')
(1500.5, 'Alice')
*/

-- Prediction Query
SELECT SUM(T2.balance), T1.name FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(1500.5, 'Alice')
(200.0, 'Bob')
*/