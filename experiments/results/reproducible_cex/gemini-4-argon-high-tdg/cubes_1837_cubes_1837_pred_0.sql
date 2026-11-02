-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'University of Oxford', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'ETH Zurich', 'Switzerland');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Gibbons', 'Jeremy');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Bird', 'Richard');
INSERT INTO "Papers" ("paperID", "title") VALUES (101, 'Z-Calculus');
INSERT INTO "Papers" ("paperID", "title") VALUES (102, 'Functional Pearl');
INSERT INTO "Papers" ("paperID", "title") VALUES (103, 'Algebra of Programming');
INSERT INTO "Papers" ("paperID", "title") VALUES (104, 'Pearls of Functional Algorithm Design');
INSERT INTO "Papers" ("paperID", "title") VALUES (105, 'Orphan Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 102, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 2, 103, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 103, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 104, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Jeremy' AND "lname" = 'Gibbons') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Algebra of Programming',)
('Functional Pearl',)
('Z-Calculus',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Jeremy' AND t1.lname = 'Gibbons';

/*
Prediction Result:
('Z-Calculus',)
('Functional Pearl',)
('Algebra of Programming',)
*/