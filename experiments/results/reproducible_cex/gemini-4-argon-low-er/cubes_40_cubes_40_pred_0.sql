-- Schema DDL
CREATE TABLE "i043" ("CustomerName" TEXT, "EmailAddress" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'alice@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'alice@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Bob', 'bob@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Charlie', 'bob@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customername, emailaddress FROM (SELECT customername, emailaddress, COUNT(*) AS n FROM (SELECT LHS.customername AS customername, LHS.emailaddress AS emailaddress, RHS.customername AS customername_other FROM i043 AS LHS INNER JOIN i043 AS RHS ON (LHS.emailaddress = RHS.emailaddress)) GROUP BY customername, emailaddress) WHERE (n > 1) ORDER BY customername, emailaddress NULLS LAST;

/*
Gold Result:
('Alice', 'alice@example.com')
('Bob', 'bob@example.com')
('Charlie', 'bob@example.com')
*/

-- Prediction Query
SELECT EmailAddress, CustomerName FROM i043 WHERE EmailAddress IN (SELECT EmailAddress FROM i043 GROUP BY EmailAddress HAVING COUNT(*) > 1);

/*
Prediction Result:
('alice@example.com', 'Alice')
('alice@example.com', 'Alice')
('bob@example.com', 'Bob')
('bob@example.com', 'Charlie')
*/