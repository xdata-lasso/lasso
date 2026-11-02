-- Schema DDL
CREATE TABLE "i043" ("CustomerName" TEXT, "EmailAddress" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'dup@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Alice', 'dup@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Bob', 'bob1@example.com');
INSERT INTO i043 (CustomerName, EmailAddress) VALUES ('Bob', 'bob2@example.com');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customername, emailaddress FROM (SELECT customername, emailaddress, COUNT(*) AS n FROM (SELECT LHS.customername AS customername, LHS.emailaddress AS emailaddress, RHS.customername AS customername_other FROM i043 AS LHS INNER JOIN i043 AS RHS ON (LHS.emailaddress = RHS.emailaddress)) GROUP BY customername, emailaddress) WHERE (n > 1) ORDER BY customername, emailaddress NULLS LAST;

/*
Gold Result:
('Alice', 'dup@example.com')
*/

-- Prediction Query
SELECT EmailAddress, CustomerName FROM i043 WHERE EmailAddress IN (SELECT EmailAddress FROM i043 GROUP BY EmailAddress HAVING COUNT(*) > 1);

/*
Prediction Result:
('dup@example.com', 'Alice')
('dup@example.com', 'Alice')
*/