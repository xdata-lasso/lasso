-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Delta');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Charlie');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Bravo');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Alpha');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Echo');
INSERT INTO SAVINGS (custid, balance) VALUES (3, 100.5);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 500.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 300.25);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 400.75);
INSERT INTO SAVINGS (custid, balance) VALUES (5, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (1, 999.99);
INSERT INTO CHECKING (custid, balance) VALUES (2, 888.88);
INSERT INTO CHECKING (custid, balance) VALUES (3, 777.77);
INSERT INTO CHECKING (custid, balance) VALUES (4, 666.66);
INSERT INTO CHECKING (custid, balance) VALUES (5, 555.55);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, balance FROM (SELECT * FROM (SELECT * FROM (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.name AS name FROM savings AS LHS INNER JOIN accounts AS RHS ON (LHS.custid = RHS.custid)) ORDER BY custid) LIMIT 3);

/*
Gold Result:
('Delta', 500.0)
('Charlie', 400.75)
('Bravo', 100.5)
*/

-- Prediction Query
SELECT T1.name, T2.balance FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid ORDER BY T2.balance DESC, T1.custid NULLS LAST, T2.custid NULLS LAST LIMIT 3;

/*
Prediction Result:
('Delta', 500.0)
('Charlie', 400.75)
('Alpha', 300.25)
*/