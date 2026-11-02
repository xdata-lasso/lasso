-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests empty CHECKING table while ACCOUNTS and SAVINGS are populated.
-- Catches mutants that replace the window function `SELECT DISTINCT SUM(balance) OVER ()` (which returns 0 rows on empty table) with plain aggregate `SELECT SUM(balance)` (which returns 1 row with NULL on empty table), or mutants using INNER/LEFT JOIN with ACCOUNTS/SAVINGS.
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO SAVINGS (custid, balance) VALUES (1, 500.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 600.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM(balance) OVER () AS sum_balance_ FROM checking ORDER BY sum_balance_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(balance) FROM checking;

/*
Prediction Result:
(None,)
*/