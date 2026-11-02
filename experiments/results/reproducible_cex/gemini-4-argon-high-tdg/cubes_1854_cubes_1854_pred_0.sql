-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Inst (instID, name, country) VALUES (1, 'MIT', 'USA');
INSERT INTO Inst (instID, name, country) VALUES (2, 'ETH', 'Switzerland');
INSERT INTO Papers (paperID, title) VALUES (10, 'Database Systems');
INSERT INTO Papers (paperID, title) VALUES (20, 'Query Optimization');
INSERT INTO Authors (authID, lname, fname) VALUES (1, 'Beta', 'Amal');
INSERT INTO Authors (authID, lname, fname) VALUES (2, NULL, 'Amal');
INSERT INTO Authors (authID, lname, fname) VALUES (3, 'Alpha', 'Amal');
INSERT INTO Authors (authID, lname, fname) VALUES (4, 'Alpha', 'Amal');
INSERT INTO Authors (authID, lname, fname) VALUES (5, 'Gamma', 'Alice');
INSERT INTO Authors (authID, lname, fname) VALUES (6, 'Delta', 'Bob');
INSERT INTO Authors (authID, lname, fname) VALUES (7, 'Epsilon', NULL);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (1, 1, 10, 1);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (1, 2, 20, 2);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (3, 1, 10, 2);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (5, 1, 20, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM "authors" WHERE ("fname" = 'Amal') ORDER BY lname, authors.authid NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Alpha',)
('Beta',)
*/

-- Prediction Query
SELECT lname FROM authors WHERE fname = 'Amal';

/*
Prediction Result:
('Beta',)
(None,)
('Alpha',)
('Alpha',)
*/