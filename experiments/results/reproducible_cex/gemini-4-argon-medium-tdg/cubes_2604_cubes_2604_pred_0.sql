-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty SAVINGS table, populated CHECKING table.
-- Tests scalar aggregation on empty table (AVG returns 1 row with NULL, outer COUNT(*) OVER () returns 1, whereas COUNT(meanbalance) or flattened COUNT(*) on SAVINGS returns 0, and querying CHECKING returns 2).
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO CHECKING (custid, balance) VALUES (1, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (2, 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS count___ FROM (SELECT AVG(balance) AS meanbalance FROM savings) ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM savings WHERE balance > (SELECT AVG(balance) FROM savings);

/*
Prediction Result:
(0,)
*/