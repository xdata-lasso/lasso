-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Inst" ("instid", "name", "country") VALUES (37, 'Aaron36', 'Aaron36');
INSERT INTO "Inst" ("instid", "name", "country") VALUES (22, 'Aaron36', 'Aaron36');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (23, 'Turon29', 'Aaron30');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (36, 'Turon', 'Aaron');
INSERT INTO "Papers" ("paperid", "title") VALUES (32, 'Turon33');
INSERT INTO "Papers" ("paperid", "title") VALUES (24, 'Turon31');
INSERT INTO "Authorship" ("authid", "instid", "paperid", "authorder") VALUES (36, 37, 24, 38);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Aaron' AND "lname" = 'Turon') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Turon31',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Aaron' AND t1.lname = 'Turon';

/*
Prediction Result:
('Turon31',)
*/