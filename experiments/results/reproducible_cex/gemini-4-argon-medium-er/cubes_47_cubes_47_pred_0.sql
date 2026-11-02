-- Schema DDL
CREATE TABLE "i048" ("CName" TEXT, "AddressID" INTEGER, "AddressLine" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i048 (CName, AddressID, AddressLine) VALUES ('A', 1, 'X');
INSERT INTO i048 (CName, AddressID, AddressLine) VALUES ('B', 1, 'Y');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, addressid AS minaddressid, addressline FROM (SELECT LHS.cname AS cname, LHS.addressid AS addressid, LHS.addressline AS addressline, RHS.cname AS cname_other FROM i048 AS LHS INNER JOIN (SELECT cname, MIN(addressid) AS minaddressid FROM i048 GROUP BY cname) AS RHS ON (LHS.addressid = RHS.minaddressid)) ORDER BY cname, minaddressid NULLS LAST, addressline NULLS LAST;

/*
Gold Result:
('A', 1, 'X')
('A', 1, 'X')
('B', 1, 'Y')
('B', 1, 'Y')
*/

-- Prediction Query
SELECT M.CName, first, M.AddressLine FROM (SELECT CName, MIN(AddressID) AS First FROM i048 GROUP BY CName) AS foo JOIN i048 AS M ON foo.CName = M.CName AND foo.First = M.AddressID;

/*
Prediction Result:
('A', 1, 'X')
('B', 1, 'Y')
*/