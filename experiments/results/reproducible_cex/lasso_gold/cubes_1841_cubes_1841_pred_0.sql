-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1059, 'Turon', 'Laura');
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1062, 'Turon', 'Allison');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1060, 'Arthur James', 'USA');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1063, 'Shannon Smith', 'USA');
INSERT INTO "papers" ("paperid", "title") VALUES (1061, 'Psychotherapist');
INSERT INTO "papers" ("paperid", "title") VALUES (1064, 'Colour technologist');
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1059, 1060, 1061, 2);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1062, 1063, 1064, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT * FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM "inst" AS "LHS" CROSS JOIN "authors" AS "RHS") AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("lname" = 'Turon' AND "authorder" = 2)) WHERE ("country" = 'USA' OR "lname" <> 'Turon') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Colour technologist',)
('Psychotherapist',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid JOIN inst AS t4 ON t2.instid = t4.instid WHERE t4.country = 'USA' AND t2.authorder = 2 AND t1.lname = 'Turon';

/*
Prediction Result:
('Psychotherapist',)
('Colour technologist',)
*/