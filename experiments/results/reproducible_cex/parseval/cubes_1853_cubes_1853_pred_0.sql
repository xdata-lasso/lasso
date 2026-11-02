-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: inst --
INSERT INTO "inst" ("instid", "name", "country") VALUES (1, '5k5swwqcgs', '9n8');

-- Inserting into table: authors --
INSERT INTO "authors" ("authid", "lname", "fname") VALUES (1, 'A', 'A');

-- Inserting into table: papers --
INSERT INTO "papers" ("paperid", "title") VALUES (1, 'lhs_24feac');

INSERT INTO "papers" ("paperid", "title") VALUES (3, 'lhs_24feac');

INSERT INTO "papers" ("paperid", "title") VALUES (2, '4');

-- Inserting into table: authorship --
INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 1, 1);

INSERT INTO "authorship" ("authid", "instid", "paperid", "authorder") VALUES (1, 1, 2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "authid", "authorder", COUNT(*) AS "n" FROM (SELECT "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "LHS"."authid" AS "authid", "LHS"."instid" AS "instid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM "papers" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."paperid" = "RHS"."paperid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" <> 'Atsushi' OR "lname" = 'Ohori')) AS RHS ON (LHS.authid = RHS.authid)) GROUP BY authid, authorder) ORDER BY count___;

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(*) FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Atsushi' AND t1.lname = 'Ohori';

/*
Prediction Result:
(0,)
*/