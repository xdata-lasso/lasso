-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("custid", "name") VALUES (1, 't1__a6576d');

INSERT INTO "accounts" ("custid", "name") VALUES (3, 't1__a6576d');

INSERT INTO "accounts" ("custid", "name") VALUES (2, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (4, 't1__a6576d');

INSERT INTO "accounts" ("custid", "name") VALUES (5, 't1__0cc099');

INSERT INTO "accounts" ("custid", "name") VALUES (6, 'Brown');

INSERT INTO "accounts" ("custid", "name") VALUES (7, NULL);

INSERT INTO "accounts" ("custid", "name") VALUES (8, 't1__a6576d');

-- Inserting into table: savings --
INSERT INTO "savings" ("custid", "balance") VALUES (1, 582.588439);

INSERT INTO "savings" ("custid", "balance") VALUES (2, 680.190136);

INSERT INTO "savings" ("custid", "balance") VALUES (3, 1.0);

INSERT INTO "savings" ("custid", "balance") VALUES (4, 1.0);

INSERT INTO "savings" ("custid", "balance") VALUES (6, 582.588439);

INSERT INTO "savings" ("custid", "balance") VALUES (7, 680.190136);

INSERT INTO "savings" ("custid", "balance") VALUES (8, 582.588439);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT SUM("balance") OVER () AS "sum_t2_balance_" FROM (SELECT * FROM "savings" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "accounts" WHERE ("name" = 'Brown')) AS RHS WHERE (LHS.custid = RHS.custid))) ORDER BY sum_t2_balance_;

/*
Gold Result:
(2527.55715,)
*/

-- Prediction Query
SELECT SUM(T2.balance) FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid WHERE T1.name <> 'Brown';

/*
Prediction Result:
(1847.367014,)
*/