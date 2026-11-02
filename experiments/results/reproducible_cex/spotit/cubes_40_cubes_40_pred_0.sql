-- Schema DDL
CREATE TABLE "I043" (
    "CUSTOMERNAME" TEXT,
    "EMAILADDRESS" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I043 VALUES (-1, -2);
INSERT INTO I043 VALUES (-1, -2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customername, emailaddress FROM (SELECT customername, emailaddress, COUNT(*) AS n FROM (SELECT LHS.customername AS customername, LHS.emailaddress AS emailaddress, RHS.customername AS customername_other FROM i043 AS LHS INNER JOIN i043 AS RHS ON (LHS.emailaddress = RHS.emailaddress)) GROUP BY customername, emailaddress) WHERE (n > 1) ORDER BY customername, emailaddress NULLS LAST;

/*
Gold Result:
('-1', '-2')
*/

-- Prediction Query
SELECT EmailAddress, CustomerName FROM i043 WHERE EmailAddress IN (SELECT EmailAddress FROM i043 GROUP BY EmailAddress HAVING COUNT(*) > 1);

/*
Prediction Result:
('-2', '-1')
('-2', '-1')
*/