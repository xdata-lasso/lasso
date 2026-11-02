-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Tokyo Institute', 'Japan');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Kyoto University', 'Japan');
INSERT INTO "Papers" ("paperID", "title") VALUES (101, 'Type Systems');
INSERT INTO "Papers" ("paperID", "title") VALUES (102, 'Functional Programming');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Ueno', 'Ziro');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Ueno', 'Akira');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'Ueno', 'Akira');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (40, 'Ueno', 'Ken');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (50, 'Sato', 'Ueno');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (60, 'Tanaka', 'Haru');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 2, 102, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (40, 1, 101, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (50, 1, 102, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (60, 2, 101, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname" FROM "authors" WHERE ("lname" = 'Ueno') ORDER BY fname, authors.authid NULLS LAST;

/*
Gold Result:
('Akira',)
('Akira',)
('Ken',)
('Ziro',)
*/

-- Prediction Query
SELECT fname FROM authors WHERE lname = 'Ueno';

/*
Prediction Result:
('Ziro',)
('Akira',)
('Akira',)
('Ken',)
*/