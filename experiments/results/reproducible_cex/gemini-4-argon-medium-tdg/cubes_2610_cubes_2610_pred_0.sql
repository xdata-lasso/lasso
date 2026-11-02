-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (1, 'Brown');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (2, 'Brown');
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (1, 100.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (2, 200.0);
INSERT INTO "CHECKING" ("custid", "balance") VALUES (1, 300.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("balance") OVER () AS "sum_t2_balance_" FROM (SELECT * FROM "savings" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "accounts" WHERE ("name" = 'Brown')) AS RHS WHERE (LHS.custid = RHS.custid))) ORDER BY sum_t2_balance_;

/*
Gold Result:
*/

-- Prediction Query
SELECT SUM(T2.balance) FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid WHERE T1.name <> 'Brown';

/*
Prediction Result:
(None,)
*/