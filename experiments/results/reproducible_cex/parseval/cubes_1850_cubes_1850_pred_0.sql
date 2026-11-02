-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, 'lhs_5aa544', 'lhs_aca3a8');

INSERT INTO "inst" ("instid", "name", "country") VALUES (-2147483647, 'lhs_21e3f8', 'lhs_ef817f');

INSERT INTO "inst" ("instid", "name", "country") VALUES (3, 'lhs_5aa544', 'lhs_aca3a8');

INSERT INTO "inst" ("instid", "name", "country") VALUES (2, '9n8', '4');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1, 'Blume', 'AA');

INSERT INTO "authors" ("authid", "lname", "fname") VALUES (-2147483647, 'Blume', 'AA');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (1, '5k5swwqcgs');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 1, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 2, 1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "inst" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" = 'Matthias' OR "lname" = 'Blume')) AS RHS ON (LHS.authid = RHS.authid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('9n8',)
('lhs_5aa544',)
*/

-- Prediction Query
SELECT DISTINCT t3.name FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t1.fname = 'Matthias' AND t1.lname = 'Blume';

/*
Prediction Result:
*/