-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'University of Pennsylvania', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'University of Pennsylvania', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'Harvard University', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (10, 'Smith', 'John');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Doe', 'Jane');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Paper A');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'Paper B');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 2, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (10, 1, 200, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 1, 100, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 3, 100, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count_distinct_t1_title_" FROM (SELECT "authid", "paperid", COUNT(*) AS "n" FROM (SELECT * FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'University of Pennsylvania')) GROUP BY authid, paperid) ORDER BY count_distinct_t1_title_;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT t1.title) FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'University of Pennsylvania';

/*
Prediction Result:
(2,)
*/