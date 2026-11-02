-- Schema DDL
CREATE TABLE "ACCOUNTS" (
    "CUSTID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("CUSTID")
);
CREATE TABLE "SAVINGS" (
    "CUSTID" INT,
    "BALANCE" FLOAT,
    PRIMARY KEY ("CUSTID"),
    FOREIGN KEY ("CUSTID") REFERENCES "ACCOUNTS"("CUSTID")
);
CREATE TABLE "CHECKING" (
    "CUSTID" INT,
    "BALANCE" FLOAT,
    PRIMARY KEY ("CUSTID"),
    FOREIGN KEY ("CUSTID") REFERENCES "ACCOUNTS"("CUSTID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ACCOUNTS VALUES (0, 1);
INSERT INTO ACCOUNTS VALUES (1, 1);
INSERT INTO SAVINGS VALUES (0, -240);
INSERT INTO SAVINGS VALUES (1, 1);
INSERT INTO CHECKING VALUES (0, 0);
INSERT INTO CHECKING VALUES (1, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT sumbalance AS sum_t2_balance_, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.sumbalance AS sumbalance FROM accounts AS LHS INNER JOIN (SELECT custid, SUM(balance) AS sumbalance FROM savings GROUP BY custid) AS RHS ON (LHS.custid = RHS.custid)) ORDER BY sum_t2_balance_, name NULLS LAST;

/*
Gold Result:
(-240.0, '1')
(1.0, '1')
*/

-- Prediction Query
SELECT SUM(T2.balance), T1.name FROM accounts AS T1 JOIN savings AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(-239.0, '1')
*/