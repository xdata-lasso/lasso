-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact string matching, case sensitivity, substring matching, NULL handling in WHERE, and NULL/duplicate handling in ORDER BY.
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Ueno', 'Ken');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Ueno', 'Akira');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Ueno', 'Ken');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Ueno', NULL);
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, 'ueno', 'Lower');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (6, 'UENO', 'Upper');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (7, 'Ueno ', 'TrailingSpace');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (8, 'Uenoyama', 'PrefixMatch');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (9, 'Tanaka', 'Ueno');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, NULL, 'NullLname');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname" FROM "authors" WHERE ("lname" = 'Ueno') ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
(None,)
('Akira',)
('Ken',)
('Ken',)
*/

-- Prediction Query
SELECT fname FROM authors WHERE lname = 'Ueno';

/*
Prediction Result:
('Ken',)
('Akira',)
('Ken',)
(None,)
*/