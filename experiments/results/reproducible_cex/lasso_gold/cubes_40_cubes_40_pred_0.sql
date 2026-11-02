-- Schema DDL
CREATE TABLE "i043" ("CustomerName" TEXT, "EmailAddress" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i043" ("customername", "emailaddress") VALUES ('Daniel Wagner', 'hoffmanjennifer@example.net');
INSERT INTO "i043" ("customername", "emailaddress") VALUES ('Connie Lawrence', 'hoffmanjennifer@example.net');
INSERT INTO "i043" ("customername", "emailaddress") VALUES (NULL, 'jpeterson@example.org');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customername, emailaddress FROM (SELECT customername, emailaddress, COUNT(*) AS n FROM (SELECT LHS.customername AS customername, LHS.emailaddress AS emailaddress, RHS.customername AS customername_other FROM i043 AS LHS INNER JOIN i043 AS RHS ON (LHS.emailaddress = RHS.emailaddress)) GROUP BY customername, emailaddress) WHERE (n > 1) ORDER BY customername, emailaddress NULLS LAST;

/*
Gold Result:
('Connie Lawrence', 'hoffmanjennifer@example.net')
('Daniel Wagner', 'hoffmanjennifer@example.net')
*/

-- Prediction Query
SELECT EmailAddress, CustomerName FROM i043 WHERE EmailAddress IN (SELECT EmailAddress FROM i043 GROUP BY EmailAddress HAVING COUNT(*) > 1);

/*
Prediction Result:
('hoffmanjennifer@example.net', 'Daniel Wagner')
('hoffmanjennifer@example.net', 'Connie Lawrence')
*/