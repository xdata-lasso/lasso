-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Alice');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Bob');
INSERT INTO SAVINGS (custid, balance) VALUES (1, 250.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 750.0);
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