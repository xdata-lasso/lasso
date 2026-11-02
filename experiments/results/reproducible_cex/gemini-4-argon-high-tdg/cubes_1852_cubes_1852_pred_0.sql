-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (10, 'Microsoft', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (20, 'Google', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (30, 'Stanford', 'USA');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Zeta', 'Charlie');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Alpha', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Omega', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Beta', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, 'Delta', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (20, 'Trap', 'WrongKey');
INSERT INTO "Papers" ("paperID", "title") VALUES (100, 'Distributed Systems');
INSERT INTO "Papers" ("paperID", "title") VALUES (200, 'Query Optimization');
INSERT INTO "Papers" ("paperID", "title") VALUES (300, 'Cloud Storage');
INSERT INTO "Papers" ("paperID", "title") VALUES (400, 'Unreferenced Paper');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 20, 300, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 10, 100, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 20, 200, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 20, 100, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (20, 10, 200, 4);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'Google')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Alice', 'Beta')
('Alice', 'Omega')
('Charlie', 'Zeta')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'Google';

/*
Prediction Result:
('Charlie', 'Zeta')
('Alice', 'Omega')
('Alice', 'Beta')
*/