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
INSERT INTO ACCOUNTS VALUES (-1, NULL);
INSERT INTO ACCOUNTS VALUES (0, 0);
INSERT INTO SAVINGS VALUES (-1, 0);
INSERT INTO SAVINGS VALUES (0, 0);
INSERT INTO CHECKING VALUES (0, 45);
INSERT INTO CHECKING VALUES (-1, 46);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, name FROM (SELECT LHS.custid AS custid, LHS.name AS name, LHS.balance AS balance, RHS.n AS n FROM (SELECT LHS.custid AS custid, LHS.name AS name, RHS.balance AS balance FROM accounts AS LHS INNER JOIN checking AS RHS ON (LHS.custid = RHS.custid)) AS LHS INNER JOIN (SELECT name, COUNT(*) AS n FROM accounts GROUP BY name) AS RHS ON (LHS.name = RHS.name)) ORDER BY count___, name NULLS LAST;

/*
Gold Result:
(1, '0')
*/

-- Prediction Query
SELECT COUNT(*), T1.name FROM accounts AS T1 JOIN checking AS T2 ON T1.custid = T2.custid GROUP BY T1.name;

/*
Prediction Result:
(1, None)
(1, '0')
*/