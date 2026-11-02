-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Zack');
INSERT INTO ACCOUNTS (custid, name) VALUES (10, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Alpha');
INSERT INTO ACCOUNTS (custid, name) VALUES (8, 'Bravo');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Delta');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'Echo');
INSERT INTO SAVINGS (custid, balance) VALUES (10, 200.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 500.0);
INSERT INTO SAVINGS (custid, balance) VALUES (8, 400.75);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 300.5);
INSERT INTO SAVINGS (custid, balance) VALUES (6, 100.25);
INSERT INTO CHECKING (custid, balance) VALUES (1, 999.99);
INSERT INTO CHECKING (custid, balance) VALUES (4, 100.0);
INSERT INTO CHECKING (custid, balance) VALUES (8, 900.0);
INSERT INTO CHECKING (custid, balance) VALUES (10, 200.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, balance FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM savings AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid)) ORDER BY custid) LIMIT 3);

/*
Gold Result:
('Delta', 300.5)
('Alpha', 500.0)
('Echo', 100.25)
*/

-- Prediction Query
SELECT T1.name, T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid ORDER BY T2.balance DESC, T1.custid NULLS LAST, T2.custid NULLS LAST LIMIT 3;

/*
Prediction Result:
('Alpha', 500.0)
('Bravo', 400.75)
('Delta', 300.5)
*/