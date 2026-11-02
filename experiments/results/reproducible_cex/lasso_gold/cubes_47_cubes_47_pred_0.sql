-- Schema DDL
CREATE TABLE "i048" ("CName" TEXT, "AddressID" INTEGER, "AddressLine" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('Benjamin Welch', 1011, '1834 Lewis Curve
Sanchezfort, AS 53855');
INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('Brent Jordan', 1012, '010 Chandler Union Apt. 333
Taylorburgh, KY 61138');
INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('Benjamin Welch', 1011, '1834 Lewis Curve
Sanchezfort, AS 53855');
INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('Brent Jordan', 1012, '010 Chandler Union Apt. 333
Taylorburgh, KY 61138');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, addressid AS minaddressid, addressline FROM (SELECT LHS.cname AS cname, LHS.addressid AS addressid, LHS.addressline AS addressline, RHS.cname AS cname_other FROM i048 AS LHS INNER JOIN (SELECT cname, MIN(addressid) AS minaddressid FROM i048 GROUP BY cname) AS RHS ON (LHS.addressid = RHS.minaddressid)) ORDER BY cname, minaddressid NULLS LAST, addressline NULLS LAST;

/*
Gold Result:
('Benjamin Welch', 1011, '1834 Lewis Curve\nSanchezfort, AS 53855')
('Benjamin Welch', 1011, '1834 Lewis Curve\nSanchezfort, AS 53855')
('Brent Jordan', 1012, '010 Chandler Union Apt. 333\nTaylorburgh, KY 61138')
('Brent Jordan', 1012, '010 Chandler Union Apt. 333\nTaylorburgh, KY 61138')
*/

-- Prediction Query
SELECT M.CName, first, M.AddressLine FROM (SELECT CName, MIN(AddressID) AS First FROM i048 GROUP BY CName) AS foo JOIN i048 AS M ON foo.CName = M.CName AND foo.First = M.AddressID;

/*
Prediction Result:
('Benjamin Welch', 1011, '1834 Lewis Curve\nSanchezfort, AS 53855')
('Brent Jordan', 1012, '010 Chandler Union Apt. 333\nTaylorburgh, KY 61138')
('Benjamin Welch', 1011, '1834 Lewis Curve\nSanchezfort, AS 53855')
('Brent Jordan', 1012, '010 Chandler Union Apt. 333\nTaylorburgh, KY 61138')
*/