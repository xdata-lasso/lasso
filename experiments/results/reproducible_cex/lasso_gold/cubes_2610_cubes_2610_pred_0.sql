-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1017, 'Brown');
INSERT INTO "savings" ("custid", "balance") VALUES (1017, 1018.5);
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