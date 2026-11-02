-- Schema DDL
CREATE TABLE "I048" (
    "CNAME" TEXT,
    "ADDRESSID" INT,
    "ADDRESSLINE" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO I048 VALUES (-2, -1, 1);
INSERT INTO I048 VALUES (NULL, -1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, addressid AS minaddressid, addressline FROM (SELECT LHS.cname AS cname, LHS.addressid AS addressid, LHS.addressline AS addressline, RHS.cname AS cname_other FROM i048 AS LHS INNER JOIN (SELECT cname, MIN(addressid) AS minaddressid FROM i048 GROUP BY cname) AS RHS ON (LHS.addressid = RHS.minaddressid)) ORDER BY cname, minaddressid NULLS LAST, addressline NULLS LAST;

/*
Gold Result:
(None, -1, '1')
(None, -1, '1')
('-2', -1, '1')
('-2', -1, '1')
*/

-- Prediction Query
SELECT M.CName, first, M.AddressLine FROM (SELECT CName, MIN(AddressID) AS First FROM i048 GROUP BY CName) AS foo JOIN i048 AS M ON foo.CName = M.CName AND foo.First = M.AddressID;

/*
Prediction Result:
('-2', -1, '1')
*/