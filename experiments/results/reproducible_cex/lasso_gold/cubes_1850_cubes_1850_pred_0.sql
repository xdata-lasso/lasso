-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1009, 'Blume', 'Matthias_z');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1010, 'Alyssa Gonzalez', 'Pakistan');
INSERT INTO "papers" ("paperid", "title") VALUES (1011, 'Sports administrator');
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1009, 1010, 1011, 1012);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "inst" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" = 'Matthias' OR "lname" = 'Blume')) AS RHS ON (LHS.authid = RHS.authid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Alyssa Gonzalez',)
*/

-- Prediction Query
SELECT DISTINCT t3.name FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t1.fname = 'Matthias' AND t1.lname = 'Blume';

/*
Prediction Result:
*/