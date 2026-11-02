-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1001, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1002, 'Noah Rhodes');
INSERT INTO "accounts" ("custid", "name") VALUES (1003, 'Angie Henderson');
INSERT INTO "accounts" ("custid", "name") VALUES (1004, 'Daniel Wagner');
INSERT INTO "accounts" ("custid", "name") VALUES (1005, 'Cristian Santos');
INSERT INTO "accounts" ("custid", "name") VALUES (1006, 'Connie Lawrence');
INSERT INTO "savings" ("custid", "balance") VALUES (1001, 1007.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1002, 1012.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1003, 1017.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1004, 1022.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1005, 1027.5);
INSERT INTO "savings" ("custid", "balance") VALUES (1006, 1032.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, balance FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM savings AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid)) ORDER BY custid) LIMIT 3);

/*
Gold Result:
('Allison Hill', 1007.5)
('Noah Rhodes', 1012.5)
('Angie Henderson', 1017.5)
*/

-- Prediction Query
SELECT T1.name, T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid ORDER BY T2.balance DESC, T1.custid NULLS LAST, T2.custid NULLS LAST LIMIT 3;

/*
Prediction Result:
('Connie Lawrence', 1032.5)
('Cristian Santos', 1027.5)
('Daniel Wagner', 1022.5)
*/