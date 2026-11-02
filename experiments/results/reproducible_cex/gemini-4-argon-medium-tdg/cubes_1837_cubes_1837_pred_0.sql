-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Oxford', 'UK');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Gibbons', 'Jeremy');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Gibbons', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Smith', 'Jeremy');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Jeremy', 'Gibbons');
INSERT INTO "Papers" ("paperID", "title") VALUES (10, 'Zeta Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (20, 'Alpha Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (30, 'Beta Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (40, 'Gamma Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (50, 'Unauthored Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 10, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 20, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 30, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 40, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 30, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Jeremy' AND "lname" = 'Gibbons') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Alpha Paper',)
('Zeta Paper',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Jeremy' AND t1.lname = 'Gibbons';

/*
Prediction Result:
('Zeta Paper',)
('Alpha Paper',)
*/