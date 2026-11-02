-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
-- Tests multi-affiliation authors (author affiliated with both Oxford and another institution) and swapped fname/lname detection.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (100, 'University of Oxford', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (200, 'MIT', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'LastA', 'FirstZ');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'LastZ', 'FirstA');
INSERT INTO "Papers" ("paperID", "title") VALUES (500, 'Joint Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 100, 500, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 200, 500, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 100, 500, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'University of Oxford')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('FirstA', 'LastZ')
('FirstZ', 'LastA')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'University of Oxford';

/*
Prediction Result:
('FirstZ', 'LastA')
('FirstA', 'LastZ')
*/