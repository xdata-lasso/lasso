-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("custid", "name") VALUES (1, 'lhs_c50dbf');

INSERT INTO "accounts" ("custid", "name") VALUES (3, 'lhs_c50dbf');

INSERT INTO "accounts" ("custid", "name") VALUES (2, 'acc_4a04a5');

-- Inserting into table: checking --
INSERT INTO "checking" ("custid", "balance") VALUES (1, 1.0);

INSERT INTO "checking" ("custid", "balance") VALUES (2, 1.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, LHS.balance AS balance, RHS.n AS n FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS INNER JOIN checking AS RHS ON (LHS.custid = RHS.custid)) AS LHS INNER JOIN (SELECT name, COUNT(*) AS n FROM accounts GROUP BY name) AS RHS ON (LHS.name = RHS.name)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, 'acc_4a04a5')
(2, 'lhs_c50dbf')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(1, 'acc_4a04a5')
(1, 'lhs_c50dbf')
*/