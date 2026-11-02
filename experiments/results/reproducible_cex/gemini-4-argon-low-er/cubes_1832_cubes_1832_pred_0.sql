-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'B', 'A');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'A', 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT fname, lname FROM authors ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
('A', 'B')
('B', 'A')
*/

-- Prediction Query
SELECT fname, lname FROM authors ORDER BY lname, authors.authid NULLS LAST;

/*
Prediction Result:
('B', 'A')
('A', 'B')
*/