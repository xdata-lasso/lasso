-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'Charlie');
INSERT INTO CHECKING (custid, balance) VALUES (1, 100.50);
INSERT INTO CHECKING (custid, balance) VALUES (3, 200.00);
INSERT INTO CHECKING (custid, balance) VALUES (4, 300.75);
INSERT INTO CHECKING (custid, balance) VALUES (5, 0.00);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 500.00);
INSERT INTO SAVINGS (custid, balance) VALUES (6, 600.00);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, LHS.balance AS balance, RHS.n AS n FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS INNER JOIN checking AS RHS ON (LHS.custid = RHS.custid)) AS LHS INNER JOIN (SELECT name, COUNT(*) AS n FROM accounts GROUP BY name) AS RHS ON (LHS.name = RHS.name)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'Bob')
(2, 'Alice')
(3, 'Charlie')
(3, 'Charlie')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(1, 'Alice')
(1, 'Bob')
(2, 'Charlie')
*/