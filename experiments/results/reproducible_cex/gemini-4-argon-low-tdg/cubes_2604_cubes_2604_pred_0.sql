-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Empty SAVINGS table, non-empty ACCOUNTS and CHECKING.
-- Tests: AVG() over 0 rows returns 1 row with NULL; COUNT(*) OVER () returns 1, whereas COUNT(meanbalance) or flattened COUNT(*) on SAVINGS would return 0. Also catches table-swap mutants (e.g., querying CHECKING or ACCOUNTS instead of SAVINGS).
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (1, 'Alice');
INSERT INTO "CHECKING" ("custid", "balance") VALUES (1, 100.0);
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