-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'Tokyo Univ', 'Japan');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'Kyoto Univ', 'Japan');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'Osaka Univ', 'Japan');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (4, 'Nagoya Univ', 'Japan');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Tanaka', 'Katsuhiro');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Ueno', 'Kenji');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (30, 'Ueno', 'Katsuhiro');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (40, 'Sato', 'Taro');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Paper A');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 2, 100, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (30, 3, 100, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (40, 4, 100, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."authid" AS "authid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."lname" AS "lname", "RHS"."fname" AS "fname" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."authid" AS "authid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "inst" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid")) AS "LHS" INNER JOIN (SELECT * FROM "authors" WHERE ("fname" = 'Katsuhiro' OR "lname" = 'Ueno')) AS RHS ON (LHS.authid = RHS.authid)) ORDER BY name, "name" NULLS LAST;

/*
Gold Result:
('Kyoto Univ',)
('Osaka Univ',)
('Tokyo Univ',)
*/

-- Prediction Query
SELECT DISTINCT t3.name FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t1.fname = 'Katsuhiro' AND t1.lname = 'Ueno';

/*
Prediction Result:
('Osaka Univ',)
*/