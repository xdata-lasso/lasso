-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests empty CHECKING table behavior: window function over 0 rows returns 0 rows, whereas a regular aggregate (SELECT SUM(balance) FROM checking) would return 1 row with NULL.
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (1, 'Alice');
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (1, 500.0);
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