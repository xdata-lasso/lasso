-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Inst (instID, name, country) VALUES (1, 'MIT', 'USA');
INSERT INTO Inst (instID, name, country) VALUES (2, 'Oxford', 'UK');
INSERT INTO Papers (paperID, title) VALUES (101, 'Database Systems');
INSERT INTO Papers (paperID, title) VALUES (102, 'Query Optimization');
INSERT INTO Authors (authID, lname, fname) VALUES (30, 'Smith', 'Alice');
INSERT INTO Authors (authID, lname, fname) VALUES (10, 'Zebra', 'Bob');
INSERT INTO Authors (authID, lname, fname) VALUES (20, 'Adams', 'Bob');
INSERT INTO Authors (authID, lname, fname) VALUES (40, 'Adams', 'Bob');
INSERT INTO Authors (authID, lname, fname) VALUES (5, 'Clark', 'Charlie');
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 1, 101, 1);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 2, 101, 1);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 1, 102, 2);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (20, 2, 102, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM authors ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
('Alice', 'Smith')
('Bob', 'Zebra')
('Bob', 'Adams')
('Bob', 'Adams')
('Charlie', 'Clark')
*/

-- Prediction Query
SELECT fname, lname FROM authors ORDER BY lname, authors.authid NULLS LAST;

/*
Prediction Result:
('Bob', 'Adams')
('Bob', 'Adams')
('Charlie', 'Clark')
('Alice', 'Smith')
('Bob', 'Zebra')
*/