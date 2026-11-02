-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1025, 'Garcia', 'Noah');
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1029, NULL, NULL);
INSERT INTO "inst" ("instid", "name", "country") VALUES (1026, 'Indiana University', 'Guinea-Bissau');
INSERT INTO "inst" ("instid", "name", "country") VALUES (1030, 'Indiana University', 'Guinea-Bissau');
INSERT INTO "papers" ("paperid", "title") VALUES (1027, 'Local government officer');
INSERT INTO "papers" ("paperid", "title") VALUES (1031, 'Local government officer');
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1025, 1026, 1027, 1028);
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1029, 1030, 1031, 1028);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'Indiana University') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Local government officer',)
('Local government officer',)
*/

-- Prediction Query
SELECT DISTINCT t1.title FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Indiana University';

/*
Prediction Result:
('Local government officer',)
*/