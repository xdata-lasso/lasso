-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, filtering by 'Google', duplicate retention (no DISTINCT), and non-matching rows for OUTER JOIN mutants.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Google', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'MIT', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'Google', 'UK');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Smith', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Jones', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'Doe', 'Charlie');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Paper A');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'Paper B');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 200, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 2, 100, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'Google')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Alice', 'Smith')
('Alice', 'Smith')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Google';

/*
Prediction Result:
('Alice', 'Smith')
*/