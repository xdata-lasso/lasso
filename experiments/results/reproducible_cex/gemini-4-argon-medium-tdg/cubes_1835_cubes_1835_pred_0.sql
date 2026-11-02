-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Ueno', 'Zack');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Ueno', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Ueno', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Smith', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, 'Ueno', 'Ueno');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (10, 'MIT', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (20, 'Stanford', 'USA');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'DB Testing');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'SQL Mutants');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 10, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 20, 200, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 10, 100, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname" FROM "authors" WHERE ("lname" = 'Ueno') ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
('Alice',)
('Alice',)
('Ueno',)
('Zack',)
*/

-- Prediction Query
SELECT fname FROM authors WHERE lname = 'Ueno';

/*
Prediction Result:
('Zack',)
('Alice',)
('Alice',)
('Ueno',)
*/