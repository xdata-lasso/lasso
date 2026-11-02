-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'UPenn', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Cornell', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Weirich', 'Stephanie');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Smith', 'Stephanie');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Weirich', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Doe', 'Jane');
INSERT INTO "Papers" ("paperID", "title") VALUES (10, 'Zebra Types');
INSERT INTO "Papers" ("paperID", "title") VALUES (20, 'Alpha Types');
INSERT INTO "Papers" ("paperID", "title") VALUES (30, 'Beta Types');
INSERT INTO "Papers" ("paperID", "title") VALUES (40, 'Unauthored Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 10, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 2, 20, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 30, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 30, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 2, 10, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Stephanie' AND "lname" = 'Weirich') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Types',)
('Zebra Types',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Stephanie' AND t1.lname = 'Weirich';

/*
Prediction Result:
('Zebra Types',)
('Alpha Types',)
*/