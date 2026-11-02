-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (10, 'Google', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (20, 'MIT', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (100, 'Smith', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (200, 'Jones', 'Bob');
INSERT INTO "Papers" ("paperID", "title") VALUES (1000, 'Zeta Systems');
INSERT INTO "Papers" ("paperID", "title") VALUES (2000, 'Alpha Networks');
INSERT INTO "Papers" ("paperID", "title") VALUES (3000, 'Beta Compilers');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (100, 10, 1000, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (200, 10, 2000, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (100, 20, 3000, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'Google') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Networks',)
('Zeta Systems',)
*/

-- Prediction Query
SELECT DISTINCT t1.title FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Google';

/*
Prediction Result:
('Zeta Systems',)
('Alpha Networks',)
*/