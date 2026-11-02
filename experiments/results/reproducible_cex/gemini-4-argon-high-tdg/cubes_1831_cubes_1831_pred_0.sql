-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "Inst" ("instID", "name", "country") VALUES (1, 'MIT', 'USA');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (2, 'University of Oxford', 'UK');
INSERT INTO "Inst" ("instID", "name", "country") VALUES (3, 'ETH Zurich', 'Switzerland');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (1, 'Zeta', 'charlie');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (2, 'Alpha', 'Bob');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (3, 'Beta', 'Alice');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (4, 'Gamma', 'David');
INSERT INTO "Authors" ("authID", "lname", "fname") VALUES (5, 'Delta', 'Eve');
INSERT INTO "Papers" ("paperID", "title") VALUES (1, 'Quantum Computing');
INSERT INTO "Papers" ("paperID", "title") VALUES (2, 'Relational Algebra');
INSERT INTO "Papers" ("paperID", "title") VALUES (3, 'Distributed Systems');
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (1, 2, 1, 2);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (2, 2, 2, 3);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (3, 2, 1, 1);
INSERT INTO "Authorship" ("authID", "instID", "paperID", "authOrder") VALUES (4, 1, 3, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "fname", "lname" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."instid" AS "instid", "LHS"."paperid" AS "paperid", "LHS"."authorder" AS "authorder", "RHS"."name" AS "name", "RHS"."country" AS "country" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."instid" AS "instid", "RHS"."paperid" AS "paperid", "RHS"."authorder" AS "authorder" FROM "authors" AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid")) AS "LHS" INNER JOIN (SELECT * FROM "inst" WHERE ("name" = 'University of Oxford')) AS RHS ON (LHS.instid = RHS.instid)) ORDER BY fname, "fname" NULLS LAST, "lname" NULLS LAST;

/*
Gold Result:
('Alice', 'Beta')
('Bob', 'Alpha')
('charlie', 'Zeta')
*/

-- Prediction Query
SELECT DISTINCT t1.fname, t1.lname FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN inst AS t3 ON t2.instid = t3.instid WHERE t3.name = 'University of Oxford';

/*
Prediction Result:
('charlie', 'Zeta')
('Bob', 'Alpha')
('Alice', 'Beta')
*/