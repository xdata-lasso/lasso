-- Schema DDL
CREATE TABLE "ACCOUNTS" ("custid" INTEGER PRIMARY KEY, "name" TEXT(64));

CREATE TABLE "SAVINGS" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

CREATE TABLE "CHECKING" ("custid" INTEGER PRIMARY KEY, "balance" REAL, FOREIGN KEY ("custid") REFERENCES "ACCOUNTS" ("custid"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO ACCOUNTS (custid, name) VALUES (1, 'Zara');
INSERT INTO ACCOUNTS (custid, name) VALUES (2, 'Yuki');
INSERT INTO ACCOUNTS (custid, name) VALUES (3, 'Xander');
INSERT INTO ACCOUNTS (custid, name) VALUES (4, 'Wendy');
INSERT INTO ACCOUNTS (custid, name) VALUES (5, 'Victor');
INSERT INTO ACCOUNTS (custid, name) VALUES (6, 'Uma');
INSERT INTO CHECKING (custid, balance) VALUES (1, 300.0);
INSERT INTO CHECKING (custid, balance) VALUES (3, 50.0);
INSERT INTO CHECKING (custid, balance) VALUES (4, 400.0);
INSERT INTO CHECKING (custid, balance) VALUES (5, 10.0);
INSERT INTO CHECKING (custid, balance) VALUES (6, 200.0);
INSERT INTO SAVINGS (custid, balance) VALUES (1, 15.0);
INSERT INTO SAVINGS (custid, balance) VALUES (2, 999.0);
INSERT INTO SAVINGS (custid, balance) VALUES (4, 5.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT name, AVG(balance) AS meanbalance FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS LEFT JOIN checking AS RHS ON (LHS.custid = RHS.custid)) GROUP BY name) ORDER BY meanbalance) LIMIT 4);

/*
Gold Result:
('Yuki',)
('Victor',)
('Xander',)
('Uma',)
*/

-- Prediction Query
SELECT T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid WHERE T2.balance < (SELECT AVG(balance) FROM checking);

/*
Prediction Result:
('Xander',)
('Victor',)
*/