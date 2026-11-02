-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests ORDER BY lname ASC with NULLS LAST, and ensures ordering is by lname rather than authID, fname, or authOrder
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Oxford', 'UK');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Zeta', 'Aaron');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Alpha', 'Zack');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, NULL, 'Middle');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Beta', 'Bob');
INSERT INTO "Papers" ("paperID", "title") VALUES (1, 'Binders Unbound');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 1, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 1, 4);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 1, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 1, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("title" = 'Binders Unbound') ORDER BY lname, "lname" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t3.title = 'Binders Unbound';

/*
Prediction Result:
('Zeta',)
('Alpha',)
(None,)
('Beta',)
*/