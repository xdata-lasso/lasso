-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'MIT', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Shivers', 'Olin');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Shivers', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'Smith', 'Olin');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (40, 'Olin', 'Shivers');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Zeta Analysis');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'Alpha Calculus');
INSERT INTO "Papers" ("paperID", "title") VALUES (300, 'Beta Systems');
INSERT INTO "Papers" ("paperID", "title") VALUES (400, 'Gamma Types');
INSERT INTO "Papers" ("paperID", "title") VALUES (500, 'Delta Logic');
INSERT INTO "Papers" ("paperID", "title") VALUES (600, 'Epsilon Orphan');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 100, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 200, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 300, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (30, 1, 400, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (40, 1, 500, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Olin' AND "lname" = 'Shivers') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Calculus',)
('Zeta Analysis',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Olin' AND t1.lname = 'Shivers';

/*
Prediction Result:
('Zeta Analysis',)
('Alpha Calculus',)
*/