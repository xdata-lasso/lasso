-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (1, 'A');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (2, 'B');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (3, 'C');
INSERT INTO "ACCOUNTS" ("custid", "name") VALUES (4, 'D');
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (1, 10.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (2, 20.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (3, 30.0);
INSERT INTO "SAVINGS" ("custid", "balance") VALUES (4, 40.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, balance FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM savings AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid)) ORDER BY custid) LIMIT 3);

/*
Gold Result:
('A', 10.0)
('B', 20.0)
('C', 30.0)
*/

-- Prediction Query
SELECT T1.name, T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid ORDER BY T2.balance DESC, T1.custid NULLS LAST, T2.custid NULLS LAST LIMIT 3;

/*
Prediction Result:
('D', 40.0)
('C', 30.0)
('B', 20.0)
*/