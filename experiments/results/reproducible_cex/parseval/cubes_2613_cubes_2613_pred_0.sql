-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("custid", "name") VALUES (1, 't1__7271d1');

INSERT INTO "accounts" ("custid", "name") VALUES (3, 't1__7271d1');

INSERT INTO "accounts" ("custid", "name") VALUES (4, 't1__7271d1');

INSERT INTO "accounts" ("custid", "name") VALUES (5, 't1__7271d1');

INSERT INTO "accounts" ("custid", "name") VALUES (2, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483643, 'acc_e48532');

INSERT INTO "accounts" ("custid", "name") VALUES (7, 't1__e443c5');

INSERT INTO "accounts" ("custid", "name") VALUES (6, 't1__e443c5');

INSERT INTO "accounts" ("custid", "name") VALUES (8, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (9, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (10, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (11, NULL);

-- Inserting into table: savings --
INSERT INTO "savings" ("custid", "balance") VALUES (1, 582.588439);

INSERT INTO "savings" ("custid", "balance") VALUES (2, 165.344793);

INSERT INTO "savings" ("custid", "balance") VALUES (6, 3.0);

INSERT INTO "savings" ("custid", "balance") VALUES (7, 2.0);

INSERT INTO "savings" ("custid", "balance") VALUES (8, 1.0);

INSERT INTO "savings" ("custid", "balance") VALUES (9, 1.0);

INSERT INTO "savings" ("custid", "balance") VALUES (10, 582.588439);

INSERT INTO "savings" ("custid", "balance") VALUES (-2147483643, NULL);

INSERT INTO "savings" ("custid", "balance") VALUES (11, 165.344793);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumbalance AS sum_t2_balance_, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.sumbalance AS sumbalance FROM accounts AS LHS INNER JOIN (SELECT custid, SUM(balance) AS sumbalance FROM savings GROUP BY custid) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY sum_t2_balance_, name NULLS LAST;

/*
Gold Result:
(None, 'acc_e48532')
(1.0, 'acc_4a04a5')
(1.0, 'acc_4a04a5')
(2.0, 't1__e443c5')
(3.0, 't1__e443c5')
(165.344793, 'acc_4a04a5')
(165.344793, None)
(582.588439, 'acc_4a04a5')
(582.588439, 't1__7271d1')
*/

-- Prediction Query
SELECT SUM(T2.balance), T1.name FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(165.344793, None)
(749.933232, 'acc_4a04a5')
(None, 'acc_e48532')
(582.588439, 't1__7271d1')
(5.0, 't1__e443c5')
*/