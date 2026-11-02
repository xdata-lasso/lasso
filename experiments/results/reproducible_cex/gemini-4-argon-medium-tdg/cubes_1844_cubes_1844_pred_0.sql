-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: SELECT vs SELECT DISTINCT (duplicate elimination), ORDER BY ASC vs DESC, and multiple institutions named 'Google'.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Google', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Google', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'Microsoft', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Smith', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Jones', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'Lee', 'Charlie');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Zeta Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'Alpha Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (300, 'Beta Paper');
-- Paper 100 has two authors from Google (instID 1), producing duplicate 'Zeta Paper' rows in non-DISTINCT queries.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 100, 2);
-- Paper 200 has one author from Google UK (instID 2) and one from Microsoft (instID 3).
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 2, 200, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (30, 3, 200, 2);
-- Paper 300 has only a Microsoft author.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (30, 3, 300, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'Google') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Paper',)
('Zeta Paper',)
('Zeta Paper',)
*/

-- Prediction Query
SELECT DISTINCT t1.title FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Google';

/*
Prediction Result:
('Zeta Paper',)
('Alpha Paper',)
*/