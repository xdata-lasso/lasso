-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests OR vs AND vs XOR in author filter, duplicate institution names (SELECT vs SELECT DISTINCT), and NULLS LAST ordering.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Zeta Univ', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Alpha Inst', 'Germany');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, NULL, 'Canada');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (4, 'Orphan Inst', 'UK');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Felleisen', 'Matthias');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Blume', 'Robert');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Blume', 'Matthias');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Smith', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, NULL, 'Matthias');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (6, 'Blume', NULL);
INSERT INTO "Papers" ("paperID", "title") VALUES (1, 'Paper A');
INSERT INTO "Papers" ("paperID", "title") VALUES (2, 'Paper B');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 1, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 2, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 2, 1, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 3, 1, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 2, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (5, 2, 2, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (6, 2, 2, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "inst" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" = 'Matthias' OR "lname" = 'Blume')) AS RHS ON (LHS.authid = RHS.authid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Inst',)
('Alpha Inst',)
('Alpha Inst',)
('Zeta Univ',)
('Zeta Univ',)
*/

-- Prediction Query
SELECT DISTINCT t3.name FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t1.fname = 'Matthias' AND t1.lname = 'Blume';

/*
Prediction Result:
(None,)
*/