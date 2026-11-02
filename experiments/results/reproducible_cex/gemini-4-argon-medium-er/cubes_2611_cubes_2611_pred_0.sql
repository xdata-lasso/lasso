-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO CHECKING (custid, balance) VALUES (1, 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT name, AVG(balance) AS meanbalance FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS LEFT JOIN checking AS RHS ON (LHS.custid = RHS.custid)) GROUP BY name) ORDER BY meanbalance) LIMIT 4);

/*
Gold Result:
('Alice',)
*/

-- Prediction Query
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT AVG(balance) FROM checking);

/*
Prediction Result:
*/