-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Inst (instID, name, country) VALUES (100, 'MPI-SWS', 'Germany');
INSERT INTO Authors (authID, lname, fname) VALUES (10, 'Turon', 'Aaron');
INSERT INTO Authors (authID, lname, fname) VALUES (20, 'Hopper', 'Grace');
INSERT INTO Papers (paperID, title) VALUES (1, 'Zebra');
INSERT INTO Papers (paperID, title) VALUES (2, 'Apple');
INSERT INTO Papers (paperID, title) VALUES (3, 'Mango');
INSERT INTO Papers (paperID, title) VALUES (4, 'Compiler');
INSERT INTO Papers (paperID, title) VALUES (5, 'Unclaimed');
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 100, 1, 3);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 100, 2, 2);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (10, 100, 3, 1);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (20, 100, 1, 1);
INSERT INTO Authorship (authID, instID, paperID, authOrder) VALUES (20, 100, 4, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "title" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "LHS"."paperid" AS "paperid", "LHS"."title" AS "title", "RHS"."instid" AS "instid", "RHS"."authorder" AS "authorder" FROM (SELECT "LHS"."authid" AS "authid", "LHS"."lname" AS "lname", "LHS"."fname" AS "fname", "RHS"."paperid" AS "paperid", "RHS"."title" AS "title" FROM "authors" AS "LHS" CROSS JOIN "papers" AS "RHS") AS "LHS" INNER JOIN "authorship" AS "RHS" ON ("LHS"."authid" = "RHS"."authid" AND "LHS"."paperid" = "RHS"."paperid")) WHERE ("fname" = 'Aaron' AND "lname" = 'Turon') ORDER BY title, "title" NULLS LAST;

/*
Gold Result:
('Apple',)
('Mango',)
('Zebra',)
*/

-- Prediction Query
SELECT t3.title FROM authors AS t1 JOIN authorship AS t2 ON t1.authid = t2.authid JOIN papers AS t3 ON t2.paperid = t3.paperid WHERE t1.fname = 'Aaron' AND t1.lname = 'Turon';

/*
Prediction Result:
('Zebra',)
('Apple',)
('Mango',)
*/