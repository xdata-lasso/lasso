-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO ACCOUNTS (custid, name) VALUES (10, 'Zoe');
INSERT INTO ACCOUNTS (custid, name) VALUES (20, 'Aaron');
INSERT INTO ACCOUNTS (custid, name) VALUES (30, 'Mike');
INSERT INTO ACCOUNTS (custid, name) VALUES (40, NULL);
INSERT INTO CHECKING (custid, balance) VALUES (10, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (20, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (30, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (40, 50.0);
INSERT INTO SAVINGS (custid, balance) VALUES (10, 20.0);
INSERT INTO SAVINGS (custid, balance) VALUES (20, 10.0);
INSERT INTO SAVINGS (custid, balance) VALUES (30, 10.0);
INSERT INTO SAVINGS (custid, balance) VALUES (40, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT balance AS balance___1, balance_other AS balance___2, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance, RHS.balance_other AS balance_other FROM accounts AS LHS INNER JOIN (SELECT LHS.custid AS custid, LHS.balance AS balance, RHS.balance AS balance_other FROM checking AS LHS INNER JOIN savings AS RHS ON (LHS.custid = RHS.custid)) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY balance___1, balance___2 NULLS LAST, name NULLS LAST;

/*
Gold Result:
(50.0, 10.0, 'Aaron')
(50.0, 10.0, 'Mike')
(50.0, 10.0, None)
(50.0, 20.0, 'Zoe')
*/

-- Prediction Query
SELECT T2.balance, T3.balance, T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid JOIN savings AS T3 ON T1.custid = T3.custid;

/*
Prediction Result:
(50.0, 20.0, 'Zoe')
(50.0, 10.0, 'Aaron')
(50.0, 10.0, 'Mike')
(50.0, 10.0, None)
*/