-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, NULL);
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'David');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'Eve');
INSERT INTO SAVINGS (custid, balance) VALUES (1, 200.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (3, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 100.0);
INSERT INTO SAVINGS (custid, balance) VALUES (5, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (1, 999.0);
INSERT INTO CHECKING (custid, balance) VALUES (2, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (6, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumbalance AS sum_t2_balance_, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.sumbalance AS sumbalance FROM accounts AS LHS INNER JOIN (SELECT custid, SUM(balance) AS sumbalance FROM savings GROUP BY custid) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY sum_t2_balance_, name NULLS LAST;

/*
Gold Result:
(50.0, 'David')
(100.0, 'Alice')
(100.0, 'Bob')
(100.0, None)
(200.0, 'Charlie')
*/

-- Prediction Query
SELECT SUM(T2.balance), T1.name FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(100.0, None)
(100.0, 'Alice')
(100.0, 'Bob')
(200.0, 'Charlie')
(50.0, 'David')
*/