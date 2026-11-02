-- Schema DDL
CREATE TABLE "Inst" ("instID" INTEGER PRIMARY KEY, "name" TEXT, "country" TEXT);

CREATE TABLE "Authors" ("authID" INTEGER PRIMARY KEY, "lname" TEXT, "fname" TEXT);

CREATE TABLE "Papers" ("paperID" INTEGER PRIMARY KEY, "title" TEXT);

CREATE TABLE "Authorship" ("authID" INTEGER, "instID" INTEGER, "paperID" INTEGER, "authOrder" INTEGER, PRIMARY KEY ("authID", "instID", "paperID"), FOREIGN KEY ("paperID") REFERENCES "Papers" ("paperID"), FOREIGN KEY ("instID") REFERENCES "Inst" ("instID"), FOREIGN KEY ("authID") REFERENCES "Authors" ("authID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Inst" ("instid", "name", "country") VALUES (21, '142', '142');
INSERT INTO "Inst" ("instid", "name", "country") VALUES (32, '142', '142');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (22, '142', '142');
INSERT INTO "Authors" ("authid", "lname", "fname") VALUES (31, '142', '142');
INSERT INTO "Papers" ("paperid", "title") VALUES (24, NULL);
INSERT INTO "Papers" ("paperid", "title") VALUES (23, NULL);
INSERT INTO "Authorship" ("authid", "instid", "paperid", "authorder") VALUES (31, 32, 23, 142);
INSERT INTO "Authorship" ("authid", "instid", "paperid", "authorder") VALUES (31, 32, 24, 142);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT title FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, LHS.authid AS authid, LHS.instid AS instid, LHS.authorder AS authorder FROM (SELECT LHS.paperid AS paperid, LHS.title AS title, RHS.authid AS authid, RHS.instid AS instid, RHS.authorder AS authorder FROM papers AS LHS INNER JOIN authorship AS RHS ON (LHS.paperid = RHS.paperid)) AS LHS INNER JOIN (SELECT authid, instid, paperid, MAX(authorder) OVER () AS authorder FROM authorship) AS RHS ON (LHS.paperid = RHS.paperid AND LHS.authid = RHS.authid AND LHS.instid = RHS.instid AND LHS.authorder = RHS.authorder)) ORDER BY title;

/*
Gold Result:
(None,)
(None,)
*/

-- Prediction Query
SELECT t2.title FROM authorship AS t1 JOIN papers AS t2 ON t1.paperid = t2.paperid WHERE t1.authorder = (SELECT MAX(authorder) FROM authorship);

/*
Prediction Result:
(None,)
(None,)
*/