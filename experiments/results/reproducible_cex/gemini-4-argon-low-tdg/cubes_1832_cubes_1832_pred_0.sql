-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by fname ASC, and secondary ordering by authID ASC (inverted from insertion/lname order), plus duplicate (fname, lname) pairs to kill DISTINCT mutants.
INSERT INTO Authors (authID, lname, fname) VALUES (30, 'Zeta', 'Alice');
INSERT INTO Authors (authID, lname, fname) VALUES (10, 'Beta', 'Alice');
INSERT INTO Authors (authID, lname, fname) VALUES (20, 'Beta', 'Alice');
INSERT INTO Authors (authID, lname, fname) VALUES (5, 'Alpha', 'Bob');
INSERT INTO Authors (authID, lname, fname) VALUES (1, 'Gamma', 'Charlie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM authors ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
('Alice', 'Beta')
('Alice', 'Beta')
('Alice', 'Zeta')
('Bob', 'Alpha')
('Charlie', 'Gamma')
*/

-- Prediction Query
SELECT fname, lname FROM authors ORDER BY lname, authors.authid NULLS LAST;

/*
Prediction Result:
('Bob', 'Alpha')
('Alice', 'Beta')
('Alice', 'Beta')
('Charlie', 'Gamma')
('Alice', 'Zeta')
*/