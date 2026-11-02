-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
-- Tests wrong join key mutations (e.g., joining on authID = instID, paperID = instID, or authOrder = instID) and multiple institutions with the name 'University of Oxford'.
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Stanford University', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'ETH Zurich', 'Switzerland');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (10, 'University of Oxford', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (20, 'University of Oxford', 'England');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'WrongInstMatch', 'One');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'WrongAuthIDMatch', 'Ten');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'TrueOxfordOne', 'Thirty');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (40, 'TrueOxfordTwo', 'Forty');
INSERT INTO "Papers" ("paperID", "title") VALUES (10, 'Paper With ID 10');
INSERT INTO "Papers" ("paperID", "title") VALUES (99, 'Paper With ID 99');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 10, 10);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 2, 99, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (30, 10, 99, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (40, 20, 99, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'University of Oxford')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Forty', 'TrueOxfordTwo')
('Thirty', 'TrueOxfordOne')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'University of Oxford';

/*
Prediction Result:
('Thirty', 'TrueOxfordOne')
('Forty', 'TrueOxfordTwo')
*/