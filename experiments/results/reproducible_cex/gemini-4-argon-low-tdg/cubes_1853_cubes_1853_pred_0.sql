-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'MIT', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Tohoku', 'Japan');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Tanaka', 'Atsushi');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Ohori', 'Atsushi');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Ohori', 'Ken');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Smith', 'John');
INSERT INTO "Papers" ("paperID", "title") VALUES (101, 'Paper A');
INSERT INTO "Papers" ("paperID", "title") VALUES (102, 'Paper B');
INSERT INTO "Papers" ("paperID", "title") VALUES (103, 'Paper C');
INSERT INTO "Papers" ("paperID", "title") VALUES (104, 'Paper D');
-- Author 1 (Tanaka, Atsushi) -> Should be EXCLUDED by WHERE (fname <> 'Atsushi' OR lname = 'Ohori'). Give count = 1.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 1, 101, 1);
-- Author 2 (Ohori, Atsushi) -> Should be INCLUDED. Give count = 2.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 1, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 2, 102, 1);
-- Author 3 (Ohori, Ken) -> Should be INCLUDED. Give count = 3.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 102, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 1, 103, 1);
-- Author 4 (Smith, John) -> Should be INCLUDED. Give count = 4.
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 102, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 103, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 104, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "authid", "authorder", COUNT(*) AS "n" FROM (SELECT "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "LHS"."authid" AS "authid", "LHS"."instid" AS "instid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM "papers" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."paperid" = "RHS"."paperid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" <> 'Atsushi' OR "lname" = 'Ohori')) AS RHS ON (LHS.authid = RHS.authid)) GROUP BY authid, authorder) ORDER BY count___;

/*
Gold Result:
(2,)
(3,)
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Atsushi' AND t1.lname = 'Ohori';

/*
Prediction Result:
(2,)
*/