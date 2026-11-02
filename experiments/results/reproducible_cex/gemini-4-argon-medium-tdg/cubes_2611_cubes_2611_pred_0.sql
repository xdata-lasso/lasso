-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: LEFT JOIN vs INNER JOIN (unmatched accounts resulting in NULL meanbalance),
-- NULL ordering (NULLs sort first in SQLite ASC), LIMIT 4 boundary with >4 distinct names,
-- and decoy data in SAVINGS to kill mutants that join the wrong table.
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'David');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Eve');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'Frank');
INSERT INTO CHECKING (custid, balance) VALUES (2, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (3, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (4, 200.0);
INSERT INTO CHECKING (custid, balance) VALUES (5, 10.0);
INSERT INTO CHECKING (custid, balance) VALUES (6, 300.0);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 9999.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 1.0);
INSERT INTO SAVINGS (custid, balance) VALUES (3, 2.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 3.0);
INSERT INTO SAVINGS (custid, balance) VALUES (5, 4.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT name, AVG(balance) AS meanbalance FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS LEFT JOIN checking AS RHS ON (LHS.custid = RHS.custid)) GROUP BY name) ORDER BY meanbalance) LIMIT 4);

/*
Gold Result:
('Alice',)
('Eve',)
('Charlie',)
('Bob',)
*/

-- Prediction Query
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT AVG(balance) FROM checking);

/*
Prediction Result:
('Bob',)
('Charlie',)
('Eve',)
*/