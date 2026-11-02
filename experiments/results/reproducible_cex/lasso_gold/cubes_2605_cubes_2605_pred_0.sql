-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(balance) OVER () AS avg_balance_ FROM checking ORDER BY avg_balance_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(balance) FROM checking;

/*
Prediction Result:
(None,)
*/