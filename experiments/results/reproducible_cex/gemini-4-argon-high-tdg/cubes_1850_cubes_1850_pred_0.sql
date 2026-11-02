-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Zeta University', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Omega Institute', 'Germany');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'Beta College', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (4, 'Alpha Academy', 'Canada');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (5, 'Gamma Tech', 'France');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Blume', 'Matthias');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Felleisen', 'Matthias');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Blume', 'Judy');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Matthias', 'Blume');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, 'Smith', 'John');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Paper One');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 2, 100, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 3, 100, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 4, 100, 4);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (5, 5, 100, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "inst" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" = 'Matthias' OR "lname" = 'Blume')) AS RHS ON (LHS.authid = RHS.authid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Beta College',)
('Omega Institute',)
('Zeta University',)
*/

-- Prediction Query
SELECT DISTINCT t3.name FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t1.fname = 'Matthias' AND t1.lname = 'Blume';

/*
Prediction Result:
('Zeta University',)
*/