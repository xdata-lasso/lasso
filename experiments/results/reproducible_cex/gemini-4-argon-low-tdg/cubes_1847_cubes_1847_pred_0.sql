-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Tokyo Univ', 'Japan');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Osaka Univ', 'Japan');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Ohori', 'Atsushi');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Ohori', 'Ken');
INSERT INTO "Papers" ("paperID", "title") VALUES (10, 'Zeta Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (20, 'Alpha Paper');
INSERT INTO "Papers" ("paperID", "title") VALUES (30, NULL);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 10, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 2, 10, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 20, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 30, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM "inst" AS "LHS" CROSS JOIN "authors" AS "RHS") AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("country" = 'Japan' AND "lname" = 'Ohori') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Paper',)
('Zeta Paper',)
('Zeta Paper',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid JOIN inst AS t4 ON t2.instid = t4.instid WHERE t4.country = 'Japan' AND t2.authorder = 1 AND t1.lname = 'Ohori';

/*
Prediction Result:
('Zeta Paper',)
(None,)
*/