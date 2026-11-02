-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic positive match, ORDER BY direction (ASC vs DESC), NULLS LAST vs NULLS FIRST, and filters on fname/lname (AND vs OR, exact match vs LIKE/case-sensitivity).
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'MPI', 'Germany');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Turon', 'Aaron');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Smith', 'Aaron');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Turon', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'turon', 'aaron');
INSERT INTO "Papers" ("paperID", "title") VALUES (10, 'Zeta');
INSERT INTO "Papers" ("paperID", "title") VALUES (20, 'Alpha');
INSERT INTO "Papers" ("paperID", "title") VALUES (30, NULL);
INSERT INTO "Papers" ("paperID", "title") VALUES (40, 'Unmatched');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 10, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 20, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 30, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 40, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 40, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 40, 3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Aaron' AND "lname" = 'Turon') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Aaron' AND t1.lname = 'Turon';

/*
Prediction Result:
('Zeta',)
('Alpha',)
(None,)
*/