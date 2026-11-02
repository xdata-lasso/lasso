-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1092, 'Brown');
INSERT INTO "accounts" ("custid", "name") VALUES (1096, 'Brown');
INSERT INTO "accounts" ("custid", "name") VALUES (1097, 'Brown');
INSERT INTO "accounts" ("custid", "name") VALUES (1101, 'Brown');
INSERT INTO "checking" ("custid", "balance") VALUES (1092, 1094.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1097, 1093.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1092, 1094.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1097, 1095.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "balance" AS "balance___1", "balance_other" AS "balance___2" FROM (SELECT "LHS"."custid" AS "custid", "LHS"."balance" AS "balance", "LHS"."name" AS "name", "RHS"."balance" AS "balance_other" FROM (SELECT * FROM (SELECT "LHS"."custid" AS "custid", "LHS"."balance" AS "balance", "RHS"."name" AS "name" FROM "checking" AS "LHS" LEFT JOIN "accounts" AS "RHS" ON ("LHS"."custid" = "RHS"."custid")) WHERE ("name" = 'Brown')) AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST;

/*
Gold Result:
(1093.5, 1095.5)
(1094.5, 1094.5)
*/

-- Prediction Query
SELECT T2.balance, T3.balance FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid WHERE T1.name = 'Brown';

/*
Prediction Result:
(1094.5, 1094.5)
(1093.5, 1095.5)
*/