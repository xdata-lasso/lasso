-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "accounts" ("custid", "name") VALUES (1001, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1002, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1003, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1004, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1005, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1006, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1007, 'Allison Hill');
INSERT INTO "accounts" ("custid", "name") VALUES (1016, 'Allison Hill');
INSERT INTO "checking" ("custid", "balance") VALUES (1001, 1008.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1002, 1013.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1003, 1018.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1004, 1023.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1005, 1028.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1006, 1033.5);
INSERT INTO "checking" ("custid", "balance") VALUES (1007, 1038.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT name, AVG(balance) AS meanbalance FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS LEFT JOIN checking AS RHS ON (LHS.custid = RHS.custid)) GROUP BY name) ORDER BY meanbalance) LIMIT 4);

/*
Gold Result:
('Allison Hill',)
*/

-- Prediction Query
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT AVG(balance) FROM checking);

/*
Prediction Result:
('Allison Hill',)
('Allison Hill',)
('Allison Hill',)
*/