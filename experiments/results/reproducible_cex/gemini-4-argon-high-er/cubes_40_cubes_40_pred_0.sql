-- Schema DDL
CREATE TABLE "i043" ("CustomerName" TEXT, "EmailAddress" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'a@b.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'a@b.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Bob', 'a@b.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customername, emailaddress FROM (SELECT customername, emailaddress, COUNT(*) AS n FROM (SELECT LHS.customername AS customername, LHS.emailaddress AS emailaddress, RHS.customername AS customername_other FROM i043 AS LHS INNER JOIN i043 AS RHS ON (LHS.emailaddress = RHS.emailaddress)) GROUP BY customername, emailaddress) WHERE (n > 1) ORDER BY customername, emailaddress NULLS LAST;

/*
Gold Result:
('Alice', 'a@b.com')
('Bob', 'a@b.com')
*/

-- Prediction Query
SELECT EmailAddress, CustomerName FROM i043 WHERE EmailAddress IN (SELECT EmailAddress FROM i043 GROUP BY EmailAddress HAVING COUNT(*) > 1);

/*
Prediction Result:
('a@b.com', 'Alice')
('a@b.com', 'Alice')
('a@b.com', 'Bob')
*/