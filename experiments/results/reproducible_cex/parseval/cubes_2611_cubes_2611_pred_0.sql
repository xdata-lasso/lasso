-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: accounts --
INSERT INTO "accounts" ("custid", "name") VALUES (1, 'lhs_aa03de');

INSERT INTO "accounts" ("custid", "name") VALUES (2, 'lhs_aa03de');

INSERT INTO "accounts" ("custid", "name") VALUES (3, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (4, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (5, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (6, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (7, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483641, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483640, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483639, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483638, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (8, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (9, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (10, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (11, 'acc_4a04a5');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483633, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483632, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483631, 'q_3_9424dd');

INSERT INTO "accounts" ("custid", "name") VALUES (-2147483630, 'q_3_9424dd');

-- Inserting into table: checking --
INSERT INTO "checking" ("custid", "balance") VALUES (1, 1.0);

INSERT INTO "checking" ("custid", "balance") VALUES (3, 1.0);

INSERT INTO "checking" ("custid", "balance") VALUES (4, 165.344793);

INSERT INTO "checking" ("custid", "balance") VALUES (5, 285.529132);

INSERT INTO "checking" ("custid", "balance") VALUES (6, 357.862717);

INSERT INTO "checking" ("custid", "balance") VALUES (7, 792.996259);

INSERT INTO "checking" ("custid", "balance") VALUES (8, 38.668834);

INSERT INTO "checking" ("custid", "balance") VALUES (9, 292.730571);

INSERT INTO "checking" ("custid", "balance") VALUES (10, 572.766956);

INSERT INTO "checking" ("custid", "balance") VALUES (11, 206.939346);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT name, AVG(balance) AS meanbalance FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS LEFT JOIN checking AS RHS ON (LHS.custid = RHS.custid)) GROUP BY name) ORDER BY meanbalance) LIMIT 4);

/*
Gold Result:
('q_3_9424dd',)
('lhs_aa03de',)
('acc_4a04a5',)
*/

-- Prediction Query
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT AVG(balance) FROM checking);

/*
Prediction Result:
('lhs_aa03de',)
('acc_4a04a5',)
('acc_4a04a5',)
('acc_4a04a5',)
('acc_4a04a5',)
*/