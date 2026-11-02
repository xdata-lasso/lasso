-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (10, 'Indiana University', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (20, 'Purdue University', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1001, 'Smith', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1002, 'Jones', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1003, 'Taylor', 'Carol');
INSERT INTO "Papers" ("paperID", "title") VALUES (101, 'Quantum Computing');
INSERT INTO "Papers" ("paperID", "title") VALUES (102, 'Algorithms');
INSERT INTO "Papers" ("paperID", "title") VALUES (103, 'Database Systems');
INSERT INTO "Papers" ("paperID", "title") VALUES (104, 'Unpublished Draft');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1001, 10, 101, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1002, 10, 102, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1002, 20, 103, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."authid" AS "authid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."instid" AS "instid", "LHS"."name" AS "name", "LHS"."country" AS "country", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "inst" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."instid" = "RHS"."instid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("name" = 'Indiana University') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Algorithms',)
('Quantum Computing',)
*/

-- Prediction Query
SELECT DISTINCT t1.title FROM papers AS t1 JOIN authorship AS t2 ON t1.paperid = t2.paperid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Indiana University';

/*
Prediction Result:
('Quantum Computing',)
('Algorithms',)
*/